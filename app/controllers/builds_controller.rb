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
    @museum_object = MuseumObject.find params[:museum_object_id]
    set_variables_for step 
    render_wizard
  end

  def new
    redirect_to wizard_path steps.first
  end
  
  def update
    @museum_object = MuseumObject.find params[:museum_object_id]
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
        @kind_of_objects = TermlistKindOfObject.where( 
                             termlist_material_specified: material_specified)
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
    @building = true # used for progress bar in application layout for now
    @step = step
    @museum_object.update_column :current_build_step, step
    
    if step == :step_material
      @materials = TermlistMaterial.all.order name: :asc
    end
    
    if step == :step_museum
      @museums = Museum.where name: "JAM" # we restrict to the JAM museum for now
      @storages = @museums.first.storages
      # set correct collections if view gets rendered again (i.e. validation error or jump to view for edit)
      # first look if param exist, which means view got just rendered again with a storage choosen by user
      # which is default behaviour for input fields related to the object
      # if no user choice found look if object has storage location defined
      @selected_storage_id = params.dig(:storage, :storage_id) || @museum_object&.storage_location&.storage&.id || ""
      @storage_locations = @storages.find_by(id: @selected_storage_id)&.storage_locations || {}
    end
    
    if step == :step_provenance
      @excavation_site_categories = TermlistExcavationSiteCategory.all.order name: :asc
      @selected_excavation_site_category = TermlistExcavationSiteCategory.first
      @excavation_site_kinds = @selected_excavation_site_category.termlist_excavation_site_kinds
    end
    
    if step == :step_material_specified
      @materials = TermlistMaterial.where(id: session[:material_ids]).order name: :asc
    end
    
    if step == :step_kind_of_object
      material_specifieds_ids = @museum_object.termlist_material_specifieds.ids # get ids for choosen spec. materials
      # after that get kind of objects that belongs to the choosen spec. materials
      #@kind_of_objects = TermlistKindOfObject.joins(:termlist_material_specified).where termlist_material_specifieds: {id: material_specifieds_ids}
      @kind_of_objects = [] # note that nil results in 'Yes/No' selection in view..
    end
    
    if step == :step_kind_of_object_specified
      kind = @museum_object.termlist_kind_of_object
      @kind_of_object_specifieds = kind&.termlist_kind_of_object_specifieds
    end
    
    if step == :step_production
      kind_of_object_specified_id = @museum_object.termlist_kind_of_object_specified.id # get ids for choosen spec. materials
      # after that get productions that belongs to the choosen specific kind of object
      kind_specified = TermlistKindOfObjectSpecified.find kind_of_object_specified_id
      @production_techniques = kind_specified.termlist_production_techniques
    end
    
    if step == :step_color
      kind_of_object_specified_id = @museum_object.termlist_kind_of_object_specified.id # get ids for choosen spec. materials
      # after that get productions that belongs to the choosen specific kind of object
      kind_specified = TermlistKindOfObjectSpecified.find kind_of_object_specified_id
      @colors = kind_specified.termlist_colors
    end
    
    if step == :step_decoration
      kind_of_object_specified_id = @museum_object.termlist_kind_of_object_specified.id # get ids for choosen spec. materials
      # after that get productions that belongs to the choosen specific kind of object
      kind_specified = TermlistKindOfObjectSpecified.find kind_of_object_specified_id
      @decorations = kind_specified.termlist_decorations
      @decoration_colors = kind_specified.termlist_decoration_colors
    end
    
    if step == :step_inscription
      kind_of_object_specified_id = @museum_object.termlist_kind_of_object_specified.id # get ids for choosen spec. materials
      # after that get productions that belongs to the choosen specific kind of object
      kind_specified = TermlistKindOfObjectSpecified.find kind_of_object_specified_id
      @inscription_letters = kind_specified.termlist_inscription_letters
      @inscription_language = kind_specified.termlist_inscription_languages
    end
    
    if step == :step_preservation
      kind_of_object_specified_id = @museum_object.termlist_kind_of_object_specified.id # get ids for choosen spec. materials
      # after that get productions that belongs to the choosen specific kind of object
      kind_specified = TermlistKindOfObjectSpecified.find kind_of_object_specified_id
      @preservation_materials = kind_specified.termlist_preservation_materials
      @preservation_objects = kind_specified.termlist_preservation_objects
    end
    
    if step == :step_dating
      kind_of_object_specified_id = @museum_object.termlist_kind_of_object_specified.id # get ids for choosen spec. materials
      # after that get productions that belongs to the choosen specific kind of object
      kind_specified = TermlistKindOfObjectSpecified.find kind_of_object_specified_id
      @dating_periods = kind_specified.termlist_dating_periods
      @dating_millennia = kind_specified.termlist_dating_millennia
      @dating_centuries = kind_specified.termlist_dating_centuries
    end
    
    if step == :step_images_upload
      @museum_object.images ||= MuseumObjectImageList.new
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
                                          :termlist_production_technique_id, :termlist_decoration_id, :termlist_decoration_color_id,
                                          :termlist_inscription_letter_id, :termlist_inscription_language_id,
                                          :remaining_length, :remaining_width, :remaining_height, :remaining_opening_dm, :remaining_bottom_dm, :remaining_weight_in_gram,
                                          :termlist_preservation_material_id, :termlist_preservation_object_id, :description_conservation,
                                          :remarks, :literature, :dating_timespan_begin, :dating_timespan_end, :main_image, :is_finished,
                                          :site_number_jadis, :coordinates_mega_long, :coordinates_mega_lat,
                                          images: [],
                                          termlist_dating_century_ids: [],
                                          termlist_material_specified_ids: [], 
                                          termlist_color_ids: [],                                   
                                          excavation_site_attributes: [:id, :_destroy],
                                          images_attributes: [:id, :main, list: []]
    end                                
  end
  
end
