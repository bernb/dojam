class BuildsController < ApplicationController
  include Wicked::Wizard
  steps :step_museum, :step_acquisition, :step_provenance, :step_confirm
  
  def show
    @museum_object = MuseumObject.find params[:museum_object_id]
    @museums = Museum.where name: "JAM" # we restrict to the JAM museum for now
    @storages = @museums.first.storages
    @storage_locations = @storages.first.storage_locations
    
    @selected_storage = @storages.first
    
    render_wizard
  end

  def new
    redirect_to wizard_path steps.first
  end
  
  def update
    @museum_object = MuseumObject.find params[:museum_object_id]
    @museum_object.update_attributes museum_object_params
    render_wizard @museum_object # does also attempt to save and renders same view again if fails
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
  
  private
  def museum_object_params
    params.require(:museum_object).permit(:inv_number, :inv_extension, :inv_numberdoa, :amount, :storage_location_id)
  end
  
end
