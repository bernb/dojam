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
    respond_to do |format|
      format.html do
        redirect_to museum_object_build_path params[:id], :step_confirm
      end
      format.pdf do
        @museum_object = MuseumObject.find(params[:id]).decorate
        render pdf: @museum_object.full_inv_number,
          template: "museum_objects/overview.pdf.erb",
          layout: "overview.html.erb"
      end
    end
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
    if params.has_key?(:fulltext_search)
      page = params[:page] || 1
      @results = MuseumObject.search(params[:fulltext_search]).page(page)
      if @results.blank?
        flash[:info] = "No results found for search string \"#{params[:fulltext_search]}\""
      end
    end
  end

  def search_form
    if params.has_key?(:form_search)
      terms = {}
      results = []
      params.each do |k,v|
        next unless k.to_s.starts_with?('search_form_field')
        term = k.gsub('search_form_field_', '').titleize.gsub(' ', '')
        terms[term] = params[k]
      end

      terms.each do |k,v|
        termclass = k.to_s.constantize
        term = termclass.find v
        if k.in?(["Material", "MaterialSpecified", "KindOfObject", "KindOfObjectSpecified"])
          paths = Path.where("path LIKE ?", term.paths.first.path + "%")
          prim = MuseumObject.where(main_path: paths)
          sec = MuseumObject.joins(:museum_object_paths).where(museum_object_paths: {path_id: paths.ids})
          results +=  sec + prim
          next
        end
        results += term.museum_objects 
      end
      page = params[:page] || 1
      @results =  Kaminari.paginate_array(results).page(page)
    end
    render 'search'
  end

  def add_search_field
    respond_to do |format|
      format.js do
        selected_term = params[:selected_term]
        unless Termlist.list_types_humanized.include?(selected_term)
          flash[:error] = "Invalid term sent"
          redirect_to museum_objects_search_path
        end
        termclass = selected_term.titleize.gsub(' ', '').constantize
        @term = "search_form_field_" + selected_term.gsub(' ','_')
        terms = termclass.all
        @list = terms.map{|t| [t.name, t.id]}
      end
    end
  end

  def search_result_fulltext
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
