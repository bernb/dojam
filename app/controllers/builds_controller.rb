class BuildsController < ApplicationController
  include Wicked::Wizard
  steps :museum, :acquisition, :provenance, :confirm

  def new
    @museum_object = MuseumObject.create
    #redirect_to wizard_path steps.first, museum_object_id: @museum_object.id
  end
  
end
