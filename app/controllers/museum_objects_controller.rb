class MuseumObjectsController < ApplicationController
  
  def index
  end

  def show
  end
  
  def new
    @museum_object = MuseumObject.create
    redirect_to new_museum_object_build_path @museum_object.id
  end

  def create
  end

  def update
  end
end
