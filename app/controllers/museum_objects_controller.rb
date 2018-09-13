class MuseumObjectsController < ApplicationController
  
  def index
  if params.has_key? :search_query
    museum_objects = MuseumObject.search "#{params[:search_query]}"
  else
    musem_objects = MuseumObject.find :all, limit: 100
  end
  @museum_cards = MuseumCardDecorator.decorate_collection(museum_objects)
	@museum_objects = museum_objects.map(&:decorate)
  # We use a hash to allow more complex variants later
  # But for now only the key is used by museum card decorator
  @variant = {"edit": nil}
  
  end

  def show
    @museum_object = MuseumObject.find params[:id]
  end
  
  def new
    @museum_object = MuseumObject.create
    redirect_to new_museum_object_build_path @museum_object.id # automatically sets correct params[:museum_object_id]
  end

  def create
  end

  def update
  end
  
  def search
  end
end
