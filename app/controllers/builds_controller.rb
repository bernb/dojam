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
  
end
