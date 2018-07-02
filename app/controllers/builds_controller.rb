class BuildsController < ApplicationController
  include Wicked::Wizard
  steps :step_museum, :step_acquisition, :step_provenance, 
        :step_material, :step_material_specified, 
        :step_kind_of_object, :step_kind_of_object_specified, :step_production, 
        :step_color, :step_decoration, :step_inscription, 
        :step_measurements, :step_preservation, :step_conservation,
        :step_authenticity, :step_dating, :step_remarks, :step_images_upload, 
        :step_literature, :step_confirm
  # ToDo: Use step-dependent routing to achieve one action per step
  # See: https://stackoverflow.com/a/27508206/1638910
  # Remember DRY and refactor step symbols into one single place then
  def show
    @museum_object = MuseumObject.find(params[:museum_object_id]).decorate
    set_variables_for step
    render_wizard
  end

  def new
    redirect_to wizard_path steps.first
  end
  
  def update
    @museum_object = MuseumObject.find(params[:museum_object_id]).decorate
    # Used i.e. in step_dating where only year is entered as string, which would result in nil without transformation
    transform_string_years_to_dates
		# We use nil Values for termlist_selection undetermined.
		# Empty values are used for empty fields which allow client side
		# enforcment of user choosing a termlist or undetermined
		replace_nil_values_with_empty
    @museum_object.assign_attributes museum_object_params unless not params.key? :museum_object # see at params method below
    allow_next_step = true
    
    if step == :step_acquisition
      handle_fuzzy_date params[:museum_object]
    end
    
    if step == :step_material
      if params[:material_ids].blank?
        flash.now[:warning] = "material must be selected"
        allow_next_step = false
      else
        session[:material_ids] = params[:material_ids]
      end
    end
    
    if @museum_object.valid? && allow_next_step
      if params[:finish] == "true"
        @museum_object.save
        jump_to(:step_confirm)
      end
      
      if step == :step_confirm
        flash[:success] = "object saved in database"
      end
    else
      set_variables_for step
      if step == :step_confirm
        flash.now[:danger] = "could not save object"
      end
    end
    
    if allow_next_step
      render_wizard @museum_object # does also attempt to save and renders same view again if fails
    else
      render_wizard
    end
    
  end
  
  def create
    museum_object = MuseumObject.find params[:museum_object_id]
    museum_object.is_finished = false
    if museum_object.save
      flash[:success] = "Object saved in database"
      redirect_to root_path
    else
      flash[:danger] = Hash.new
      flash[:danger][:not_saved] = "Could not save object."
      museum_object.errors.full_messages.each_with_index do |message, i|
        flash[:danger][i] = message
      end
      museum_object.is_finished = false
      render_wizard
    end
    
  end
  
  def kind_of_objects_for_spec_material
    respond_to do |format|
      format.js {
        material_specified = TermlistMaterialSpecified.find(
                               params[:selected_material_specified_id])
				@kind_of_objects = material_specified.termlist_kind_of_objects
      }
    end
  end
  
  def excavation_site_kinds
    respond_to do |format|
      format.js {
        excavation_site_category = TermlistExcavationSiteCategory.find params[:excavation_site_category_id]
        @excavation_site_kinds = excavation_site_category.termlist_excavation_site_kinds
      }
    end
  end
  
  def storages
    respond_to do |format|
      format.js {
        museum = Museum.find params[:museum_id]
        @storages = museum.storages
      }
    end
  end
  
  def storage_locations
    respond_to do |format|
      format.js {
        if params[:storage_id] != ""
          storage = Storage.find params[:storage_id]
          @storage_locations = storage.storage_locations
        end
      }
    end
  end
  
  def museum_prefix
    respond_to do |format|
      format.js {
        museum = Museum.find params[:museum]
        @prefix = museum.prefix
      }
    end
  end
  
  private

	def replace_nil_values_with_empty
		params[:museum_object]&.each do |key, value|
			if value=="nil"
				params[:museum_object][key] = ""
			end
		end
	end

	def step_acquisition_vars
	end

	def step_decoration_vars
  	@decoration_techniques = @museum_object.get_possible_props_for "TermlistDecorationTechnique"
    @decoration_colors = @museum_object.get_possible_props_for "TermlistDecorationColor"
    @decoration_styles = @museum_object.get_possible_props_for "TermlistDecoration"
	end

	def step_material_vars
    @materials = TermlistMaterial.all.order name: :asc
	end

	def step_museum_vars
    @museums = Museum.where name: "JAM" # we restrict to the JAM museum for now
    @storages = @museums.first.storages
    # set correct collections if view gets rendered again (i.e. validation error or jump to view for edit)
    # first look if param exist, which means view got just rendered again with a storage choosen by user
    # which is default behaviour for input fields related to the object
    # if no user choice found look if object has storage location defined
    @selected_storage_id = params.dig(:storage, :storage_id) || @museum_object&.storage_location&.storage&.id || ""
    @storage_locations = @storages.find_by(id: @selected_storage_id)&.storage_locations || {}
	end

	def step_provenance_vars
    @excavation_site_categories = TermlistExcavationSiteCategory.all.order name: :asc
    @selected_excavation_site_category = TermlistExcavationSiteCategory.first
    @excavation_site_kinds = @selected_excavation_site_category.termlist_excavation_site_kinds
	end

	def step_material_specified_vars
    @materials = TermlistMaterial.where(id: session[:material_ids]).order name: :asc
	end

	def step_kind_of_object_vars
    material_specifieds_ids = @museum_object.termlist_material_specifieds.ids # get ids for choosen spec. materials
    @kind_of_objects = [] # note that nil results in 'Yes/No' selection in view..
	end

	def step_kind_of_object_specified_vars
    kind = @museum_object.termlist_kind_of_object
		ms_koo_specs = @museum_object.main_material_specified.termlist_kind_of_object_specifieds
		@kind_of_object_specifieds = kind&.termlist_kind_of_object_specifieds.merge(ms_koo_specs)
		@kind_of_object_speicifieds = [] if @kind_of_object_specifieds.blank?
	end

	def step_color_vars
		@colors = @museum_object.get_possible_props_for "TermlistColor"
	end

	def step_production_vars
	  @production_techniques = @museum_object.get_possible_props_for "TermlistProductionTechnique"
	end

	def step_measurements_vars
	end

	def step_inscription_vars
		@inscription_letters = @museum_object.get_possible_props_for "TermlistInscriptionLetter"
		@inscription_language = @museum_object.get_possible_props_for "TermlistInscriptionLanguage"
	end

	def step_preservation_vars
    @preservation_materials = @museum_object.get_possible_props_for "TermlistPreservationMaterial"
    @preservation_objects = @museum_object.get_possible_props_for "TermlistPreservationObject"
	end

	def step_conservation_vars
	end

	def step_authenticity_vars
	end

	def step_dating_vars
    @dating_periods = @museum_object.get_possible_props_for "TermlistDatingPeriod"
    @dating_millennia = @museum_object.get_possible_props_for "TermlistDatingMillennium"
    @dating_centuries = @museum_object.get_possible_props_for "TermlistDatingCentury"
	end

	def step_remarks_vars
	end

	def step_images_upload_vars
    @museum_object.images ||= MuseumObjectImageList.new
	end

	def step_literature_vars
	end

	def step_confirm_vars
	end

  def handle_fuzzy_date museum_params
    year = museum_params["acquisition_date(1i)"]
    month = museum_params["acquisition_date(2i)"]
    day = museum_params["acquisition_date(3i)"]
    # If no year or no valid combination is given return and let it handle by validator
    if year.blank?
      return
    end
    if day.present? && month.blank?
      return
    end
    date = nil
    if day.present?
      @museum_object.assign_attributes acquisition_date_precision: 1
      date = year + "-" + month + "-" + day
    elsif month.present?
      @museum_object.assign_attributes acquisition_date_precision: 2
      date = year + "-" + month + "-" + "01"
    else
      @museum_object.assign_attributes acquisition_date_precision: 3
      date = year + "-" + "01" + "-" + "01"
    end
    @museum_object.assign_attributes acquisition_date: date
  end
  
  def set_variables_for step
		return nil unless /step_[a-z_]+/.match?(step)
    @building = true # used for progress bar in application layout for now
    @step = step # also used for partials like progress bar
    @museum_object.update_column :current_build_step, step

		# We are bit lazy/clever here:
		# If check if we can deduce the needed collection from the step name
		# otherwise call the related private method
		variable_name = "termlist_" + step.to_s.split("_", 2).second
		variable_name = variable_name.pluralize
		self.send(step.to_s + "_vars")
    
  end
  
  def transform_string_years_to_dates
    if params.dig :museum_object, :dating_timespan_begin
      params[:museum_object][:dating_timespan_begin] = Date.new(params[:museum_object][:dating_timespan_begin].to_i,1,1)
    end
    
    if params.dig :museum_object, :dating_timespan_end
      params[:museum_object][:dating_timespan_end] = Date.new(params[:museum_object][:dating_timespan_end].to_i,1,1)
    end
  end
  
  
  def museum_object_params
    if params.key? :museum_object # Used for forms that do not directly belong to model (like material) ToDo: Check for a cleaner way
      params.require(:museum_object).permit :inv_number, :inv_extension, :inv_numberdoa, :amount, :storage_location_id,
                                          :termlist_acquisition_kind_id, :termlist_acquisition_delivered_by_id, :acquisition_deliverer_name, :acquisition_date,
                                          :finding_context, :finding_remarks, :termlist_authenticity_id, :priority, :priority_determined_by,
                                          :inscription_decoration, :inscription_letters, :inscription_text, :inscription_translation, 
                                          :excavation_site_id, :termlist_material_specified_ids, :termlist_kind_of_object_id, :termlist_kind_of_object_specified_id,
                                          :is_acquisition_date_exact, :acquisition_document_number, :name_expedition, :site_number_mega, :site_number_expedition,
                                          :coordinates_mega, :termlist_excavation_site_kind_id, :termlist_dating_period_id, :termlist_dating_millennium_id,
                                          :termlist_production_technique_id, :termlist_decoration_id, :termlist_decoration_color_id, :termlist_decoration_technique_id,
                                          :termlist_inscription_letter_id, :termlist_inscription_language_id, :munsell_color,
                                          :remaining_length, :remaining_width, :remaining_height, :remaining_opening_dm, :remaining_bottom_dm, :remaining_weight_in_gram,
                                          :termlist_preservation_material_id, :termlist_preservation_object_id, :description_conservation,
                                          :remarks, :literature, :dating_timespan_begin, :dating_timespan_end, :main_image, :is_finished, :needs_conservation, :needs_cleaning,
                                          :site_number_jadis, :coordinates_mega_long, :coordinates_mega_lat, :is_dating_timespan_end_BC, :is_dating_timespan_begin_BC,
																					:termlist_material_specified_id, :termlist_priority_id,
                                          images: [],
                                          termlist_dating_century_ids: [],
                                          termlist_material_specified_ids: [], 
                                          termlist_color_ids: [],                                   
                                          excavation_site_attributes: [:id, :_destroy],
                                          images_attributes: [:id, :main, list: []]
    end                                
  end
  
end
