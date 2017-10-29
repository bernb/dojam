class BuildsController < ApplicationController
  include Wicked::Wizard
  steps :step_museum, :step_acquisition, :step_provenance, 
        :step_material, :step_material_specified, 
        :step_kind_of_object, :step_kind_of_object_specified, :step_production, 
        :step_color, :step_decoration, :step_inscription, 
        :step_measurements, :step_authenticity, :step_preservation, 
        :step_conservation, :step_dating, :step_remarks, 
        :step_literature, :step_confirm
  
  def show
    @step = step
    @museum_object = MuseumObject.find params[:museum_object_id]
    
    if step == :step_material
      @materials = TermlistMaterial.all
    end
    
    if step == :step_color
      @colors = TermlistColor.all
    end
    
    if step == :step_museum
      @museums = Museum.where name: "JAM" # we restrict to the JAM museum for now
      @storages = @museums.first.storages
      @storage_locations = @storages.first.storage_locations
      @selected_storage = @storages.first
    end
    
    if step == :step_material_specified
      @materials = TermlistMaterial.where id: session[:material_ids]
    end
    
    if step == :step_kind_of_object
      material_specifieds_ids = @museum_object.termlist_material_specifieds.ids # get ids for choosen spec. materials
      # after that get kind of objects that belongs to the choosen spec. materials
      @kind_of_objects = TermlistKindOfObject.joins(:termlist_material_specified).where termlist_material_specifieds: {id: material_specifieds_ids}
    end
    
    if step == :step_kind_of_object_specified
      kind = @museum_object.termlist_kind_of_object
      @kind_of_object_specifieds = kind.termlist_kind_of_object_specifieds
    end
    
    if step == :step_production
      material_specifieds_ids = @museum_object.termlist_material_specifieds.ids # get ids for choosen spec. materials
      # after that get productions that belongs to the choosen spec. materials
      @productions = TermlistProduction.joins(:termlist_material_specified).where termlist_material_specifieds: {id: material_specifieds_ids}
    end
    
    if step == :step_color
      material_specifieds_ids = @museum_object.termlist_material_specifieds.ids # get ids for choosen spec. materials
      # after that get productions that belongs to the choosen spec. materials
      @colors = TermlistColor.joins(:termlist_material_specified).where termlist_material_specifieds: {id: material_specifieds_ids}
    end
    
    if step == :step_decoration
      material_specifieds_ids = @museum_object.termlist_material_specifieds.ids # get ids for choosen spec. materials
      # after that get productions that belongs to the choosen spec. materials
      @decorations = TermlistDecoration.joins(:termlist_material_specified).where termlist_material_specifieds: {id: material_specifieds_ids}
      @decoration_colors = TermlistDecorationColor.joins(:termlist_material_specified).where termlist_material_specifieds: {id: material_specifieds_ids}
    end
    
    if step == :step_inscription
      material_specifieds_ids = @museum_object.termlist_material_specifieds.ids # get ids for choosen spec. materials
      # after that get productions that belongs to the choosen spec. materials
      @inscription_letters = TermlistInscriptionLetter.joins(:termlist_material_specified).where termlist_material_specifieds: {id: material_specifieds_ids}
      @inscription_language = TermlistInscriptionLanguage.joins(:termlist_material_specified).where termlist_material_specifieds: {id: material_specifieds_ids}
    end
    
    if step == :step_preservation
      material_specifieds_ids = @museum_object.termlist_material_specifieds.ids
      materials = TermlistMaterial.joins(:termlist_material_specifieds).where termlist_material_specifieds: {id: material_specifieds_ids}
      material_ids = materials.ids
      @termlist_preservation_state = TermlistPreservationState.joins(:termlist_material).where termlist_materials: {id: material_ids}
    end
    
    render_wizard
  end

  def new
    redirect_to wizard_path steps.first
  end
  
  def update
    @museum_object = MuseumObject.find params[:museum_object_id]
    @museum_object.update_attributes museum_object_params unless not params.key? :museum_object # see at params method below
    if step = :step_material
      session[:material_ids] = params[:material_ids]
    end
    render_wizard @museum_object # does also attempt to save and renders same view again if fails
  end
  
  def create
    museum_object = MuseumObject.find params[:museum_object_id]
    museum_object.is_finished = true
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
        storage = Storage.find params[:storage_id]
        @storage_locations = storage.storage_locations
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
  def museum_object_params
    if params.key? :museum_object # Used for forms that do not directly belong to model (like material) ToDo: Check for a cleaner way
      params.require(:museum_object).permit :inv_number, :inv_extension, :inv_numberdoa, :amount, :storage_location_id,
                                          :termlist_acquisition_kind_id, :termlist_acquisition_delivered_by_id, :acquisition_deliverer_name, :acquisition_date,
                                          :finding_context, :finding_remarks, :termlist_authenticity_id, :priority, :priority_determined_by,
                                          :inscription_decoration, :inscription_letters, :inscription_text, :inscription_translation, 
                                          :excavation_site_id, :termlist_material_specified_ids, :termlist_kind_of_object_id,
                                          termlist_material_specified_ids: [], 
                                          termlist_color_ids: [],                                   
                                          excavation_site_attributes: [:id, :_destroy] 
  end
                                          
                                    
  end
  
end
