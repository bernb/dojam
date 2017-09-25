class BuildsController < ApplicationController
  include Wicked::Wizard
  steps :museum, :acquisition, :provenance, :confirm
  
  def show
    @museum_object = MuseumObject.find params[:museum_object_id]
    render_wizard
  end

  def new
    redirect_to wizard_path steps.first
  end
  
end
