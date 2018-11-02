class MuseumObjectsController < ApplicationController
  
  def index
  if params.has_key? :fulltext_search
    museum_objects = MuseumObject.search "#{params[:search_query]}"
	elsif params.has_key? :inv_number_search
		searchstring = params[:inv_number_search]
		split_string = searchstring.split("-")
		museum_objects = MuseumObject.where inv_number: split_string[0]
		if split_string.size == 2
			museum_objects = museum_objects.where inv_extension: split_string[1]
		end
		if museum_objects.count == 1
			redirect_to museum_object_path(museum_objects.first)
		end
	else
    museum_objects = MuseumObject.limit 25
  end
  @museum_cards = MuseumCardDecorator.decorate_collection(museum_objects)
	@museum_objects = museum_objects.map(&:decorate)
  # We use a hash to allow more complex variants later
  # But for now only the key is used by museum card decorator
  @variant = {"edit": nil}
  
  end

  def show
		redirect_to museum_object_build_path params[:id], :step_confirm
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
