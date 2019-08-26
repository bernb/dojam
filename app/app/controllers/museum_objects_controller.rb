class MuseumObjectsController < ApplicationController
  
  def index
    museum_objects = MuseumObject.limit 25
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

  def search_result_fulltext
    page = params[:page] || 1
    # Multisearch gives a mix of terms and museum objects
    # we map those to museum objects ids and on the result
    # so that we we a active records relation of museum objects as result
    # which can be processed in a clean way, for example for pagination
    search_result = PgSearch.multisearch(params[:fulltext_search])
    museum_object_ids = search_result
      .map{|r| r.searchable_type.constantize.find r.searchable_id}
      .map{|r| r.class < Termlist ? r.museum_objects : r}
      .flatten
      .map(&:id)
      .sort
    if museum_object_ids.blank?
      flash[:info] = "No results found for search string \"#{params[:fulltext_search]}\""
      redirect_to museum_objects_search_path
    end
    @results = MuseumObject.where(id: museum_object_ids).order(:id).page(page)
  end

  def search_result_invnumber
    searchstring = params[:inv_number_search]
    split_string = searchstring.split("-")
    museum_objects = MuseumObject.where inv_number: split_string[0]
    if split_string.size == 2
      museum_objects = museum_objects.where inv_extension: split_string[1]
    end
    if museum_objects.count == 1
      redirect_to museum_object_path(museum_objects.first)
    end

    if museum_objects.count == 0
      flash[:info] = "Object with inventory number \"#{params[:inv_number_search]}\" not found"
      redirect_to museum_objects_search_path
    end

    @museum_cards = MuseumCardDecorator.decorate_collection(museum_objects)
    @museum_objects = museum_objects.map(&:decorate)
    # We use a hash to allow more complex variants later
    # But for now only the key is used by museum card decorator
    @variant = {"edit": nil}
  end

end
