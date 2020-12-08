class MuseumObjectsController < ApplicationController

  def index
    respond_to do |format|
      format.html do
        page = params[:page] || 1
        @museum_objects = MuseumObject.page(page)
        @museum_objects = MuseumObjectDecorator.decorate_collection(@museum_objects)
        # We use a hash to allow more complex variants later
        # But for now only the key is used by museum card decorator
        @variant = {"edit": nil}
      end
      format.pdf do
        ids = params[:search_result_ids]
        museum_objects = MuseumObjectDecorator.decorate_collection(MuseumObject.where(id: ids))
        #ToDo: If image is too large, two pages are used. Set max height property in top_image decorater method
        render pdf: t('search_results'),
               template: "museum_objects/museum_objects_pdf.html.erb",
               locals: {museum_objects: museum_objects},
               show_as_html: params.key?('debug')
      end
    end
  end

  def export_list
    ids = params.dig(:museum_objects_export_list, :ids).presence || "[]"
    ids = JSON.parse ids
    export = ExcelExporterHelper.create_sheet(ids)
    file = StringIO.new
    export.write file
    send_data file.string.force_encoding('binary'), filename: "export.xls"
  end

  def export_pdf
    respond_to do |format|
        format.js do
          ids = params.dig(:museum_objects_export_pdf, :ids).presence || "[]"
          ids = JSON.parse ids
          museum_objects = MuseumObject.where(id: ids).map(&:decorate)
          GenerateMuseumObjectsPdfJob.perform_later museum_objects, current_user
        end
    end
  end

  def download_pdf
    pdf = current_user.pdf_export
    current_user.pdf_export_finished = false
    current_user.save
    send_data pdf, filename: t('export') + '.pdf', type: 'application/pdf'
  end

  def check_for_new_pdf
    respond_to do |format|
      format.js do
        pdf_ready = current_user.pdf_export_finished
        render json: pdf_ready.to_s
      end
    end
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
    if params.has_key?(:fulltext_search)
      page = params[:page] || 1
      @all_results = MuseumObject.search(params[:fulltext_search])
      @all_results_ids = @all_results.ids
      @results = @all_results.page(page)
      if @results.blank?
        flash[:info] = t('no_results_found')
      end
    end
  end

  def search_form
    respond_to do |format|
      format.js do
        unless params.has_key?(:form_search)
          flash[:danger] = t('could_not_complete_search_form_search_parameter_missing')
          redirect_to museum_objects_search_path
        end
        terms = {}
        results = []
        params.each do |k,v|
          next unless k.to_s.starts_with?('search_form_field')
          term = Termlist.to_internal_type(k.gsub('search_form_field_', '').titleize.gsub(' ', ''))
          terms[term] = params[k]
        end

        if terms.blank?
          flash.now[:warning] = t('no_terms_given')
          render 'search' and return
        end

        terms.each do |k,v|
          termclass = k.to_s.constantize
          term_results = []
          v.each do |term_id|
            term = termclass.find term_id
            if k.in?(["Material", "MaterialSpecified", "KindOfObject", "KindOfObjectSpecified"])
              paths = Path.where("path LIKE ?", term.paths.first.path + "%")
              prim = MuseumObject.where(main_path: paths)
              sec = MuseumObject.joins(:museum_object_paths).where(museum_object_paths: {path_id: paths.ids})
              term_results +=  sec + prim
            else
              term_results += term.museum_objects 
            end
          end
          results << term_results.uniq
        end
        page = params[:page] || 1
        @all_results = results.reduce(&:&).uniq
        @all_results_ids = @all_results.map(&:id)
        @all_results = Kaminari.paginate_array(@all_results)
        @results =  @all_results.page(page)
        if @results.blank?
          # Info gets inserted in search_form view
        end
      end
    end
  end

  def add_search_field
    respond_to do |format|
      format.js do
        @selected_term = params[:selected_term]
        unless Termlist.list_types_humanized.include?(@selected_term)
          flash[:error] = "invalid term sent"
          redirect_to museum_objects_search_path
        end
        puts @selected_term
        termclass = Termlist.to_internal_type(@selected_term.titleize.gsub(' ', '')).constantize
        @select_tag_id = "search_form_field_" + @selected_term.gsub(' ','_')
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
      flash[:info] = t('object_not_found')
      redirect_to museum_objects_search_path
    end

    @museum_cards = MuseumCardDecorator.decorate_collection(museum_objects)
    @museum_objects = museum_objects.map(&:decorate)
    # We use a hash to allow more complex variants later
    # But for now only the key is used by museum card decorator
    @variant = {"edit": nil}
  end

end
