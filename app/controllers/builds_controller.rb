class BuildsController < ApplicationController
  include Wicked::Wizard
  steps :museum, :acquisition, :provenance, :confirm
  
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
  def builds_params
    params.require(:builds).permit(:name, :prefix, storage_location: [:id, :name, :_destroy])
  end
  
end
