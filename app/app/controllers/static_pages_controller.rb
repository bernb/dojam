class StaticPagesController < ApplicationController
  include TermlistsImporterHelper
  def menu
  end

  def new_main_account
    if User.find_by(id: 1).present?
      redirect_to root_path
    end
  end

  def create_main_account

    @email = params[:email]
    @email_confirmation = params[:email_confirmation]
    @password = params[:password]
    @password_confirmation = params[:password_confirmation]

    if @email.empty? ||
        @email_confirmation.empty? ||
        @password.empty? ||
        @password_confirmation.empty?
      error = I18n.t('please_fill_out_all_inputs')
    end
    if @email != @email_confirmation
      error = I18n.t('email_must_match_email_confirmation')
    end
    if @password != @password_confirmation
      error = I18n.t('password_must_match_password_confirmation')
    end
    if error.present?
      flash.now[:danger] = error
      render 'static_pages/new_main_account'
      return
    end
    main_account = User.new id: 1,
                            email: @email,
                            password: @password,
                            is_enabled: true,
                            has_extended_access: true
    if main_account.save
      sign_in(main_account)
      flash[:notice] = I18n.t('main_account_created')
      redirect_to root_path
    else
      flash.now[:danger] = main_account.errors
      render 'static_pages/new_main_account'
      return
    end
  end

  def jstreedata
    node_id = params[:id]
    nodes =
        case JsTreeService.prefix_of(node_id)
        when '#'
          JsTreeService.build_root
        when 'N'
          JsTreeService.build_main_for(node_id)
        when 'TP'
          JsTreeService.build_termlists_for(node_id)
        else
          []
        end
    puts nodes
    render json: nodes
  end

  def jstreetest
    authorize :admin_links, :show?
  end

  def reports
    @museum_objects = MuseumObject.order(created_at: :desc)
      .limit(10)
      .decorate
      .reject{|o| o.inv_number.blank?}
  end

  def export_termlists
    authorize :admin_links, :show?
    data = FileExportHelper.call
    send_data data, filename: "ms.zip"
  end

  def import_translations_select
    authorize :admin_links, :show?
    if session[:log_path].present?
      @log_messages = File.read(session[:log_path])
      session[:log_path] = nil
    end
  end

  def import_static_translations_select
    authorize :admin_links, :show?
    if session[:log_path].present?
      @log_messages = File.read(session[:log_path])
      session[:log_path] = nil
    end
  end

  def import_static_translations_submit
    authorize :admin_links, :show?
    file_entity = params.dig(:static_translations, :translation_file)
    warnings = {}
    filename = file_entity.original_filename
    if !correct_file_format?(file_entity, ".xls") && !correct_file_format?(file_entity, ".xlsx")
      warnings[filename.to_sym] =
          file_entity.original_filename + ": " + t('unsupported_file_format_detected_only_xls_and_xlsx_files_are_supported')
      flash[:warning] = warnings
      redirect_to import_translations_select_path
    end

    timestamp = DateTime.now.strftime("%Y-%m-%d %H:%M:%S:%L")
    filename = timestamp + "static translation import.log"
    log_path = "#{Rails.root}/log/" + filename
    session[:log_path] = log_path
    logger = ActiveSupport::TaggedLogging.new(Logger.new(log_path))
    file = File.open(file_entity)
    xlsx = Roo::Spreadsheet.open(file)
    xlsx.each_with_index do |row, i|
      name_en = row.first&.to_s&.strip
      key = TranslationHelper.clean_str(row.first&.to_s)
      name_ar = row.second&.to_s&.strip
      if name_en.nil? || name_ar.nil?
        logger.tagged("Row #{i.to_s}", "Skipped"){logger.warn "Empty cell"}
        warnings[:skipped] = t('some_rows_were_skipped_see_below_for_more_information')
        next
      end

      Translation.find_or_create_by(key: key, locale: "ar") do |t|
        t.value = name_ar
        t.save
      end
      Translation.find_or_create_by(key: key, locale: "en") do |t|
        t.value = name_en
        t.save
      end

    end
    if warnings.empty?
      flash[:success] = t('translations_successfully_imported')
    else
      flash[:warning] = warnings
    end
    I18n.backend.reload! # Translations are cached and won't show up otherwise
    redirect_to import_static_translations_select_path
  end

  def import_translations_submit
    authorize :admin_links, :show?
    file_entity = params.dig(:translations, :translation_file)
    warnings = {}
    filename = file_entity.original_filename
    if !correct_file_format?(file_entity, ".xls") && !correct_file_format?(file_entity, ".xlsx")
      warnings[filename.to_sym] = 
        file_entity.original_filename + ": " + t('unsupported_file_format_detected_only_xls_and_xlsx_files_are_supported')
      flash[:warning] = warnings
      redirect_to import_translations_select_path
    end

    timestamp = DateTime.now.strftime("%Y-%m-%d %H:%M:%S:%L")
    filename = timestamp + " translation import.log"
    log_path = "#{Rails.root}/log/" + filename
    session[:log_path] = log_path
    logger = ActiveSupport::TaggedLogging.new(Logger.new(log_path))
    file = File.open(file_entity)
    xlsx = Roo::Spreadsheet.open(file)
    xlsx.each_with_index do |row, i|
      name_en = row.first&.to_s&.strip
      name_ar = row.second&.to_s&.strip
      if name_en.nil? || name_ar.nil?
        logger.tagged("Row #{i.to_s}", "Skipped"){logger.warn "Empty cell"}
        warnings[:skipped] = t('some_rows_were_skipped_see_below_for_more_information')
        next
      end
      term = Termlist.where name_en: name_en
      if term.blank?
        term = Storage.where name_en: name_en
      end
      if term.blank?
        term = StorageLocation.where name_en: name_en
      end
      if term.blank?
        logger.tagged("Row #{i.to_s}", "Skipped"){logger.warn "Term '#{name_en}' not found."}
        warnings[:skipped] = t('some_rows_were_skipped_see_below_for_more_information')
        next
      end
      if term.count > 1
        logger.tagged("Row #{i.to_s}", "Duplicate information"){logger.info "Term '#{name_en}' found #{term.count.to_s} times in database."}
        term.each do |t|
          t.name_ar = row.second
          t.save
        end
      else
        term.first.name_ar = row.second
        term.first.save
      end
    end
    if warnings.empty?
      flash[:success] = t('translations_successfully_imported')
    else
      flash[:warning] = warnings
    end
    I18n.backend.reload! # Translations are cached and won't show up otherwise
    redirect_to import_translations_select_path
  end

  def import_termlists_select
    authorize :admin_links, :show?
    if session[:log_path].present?
      @log_messages = File.read(session[:log_path])
      session[:log_path] = nil
    end
    if session[:import_errors].present?
      @log_messages = session[:import_errors]
      session[:import_errors] = nil
    end
  end

  def import_museum_objects_from_excel_select
    authorize :admin_links, :show?
    if session[:log_path].present?
      @log_messages = File.read(session[:log_path])
      session[:log_path] = nil
    end
    if session[:import_errors].present?
      @log_messages = session[:import_errors]
      session[:import_errors] = nil
    end
  end

  def import_museum_objects_from_excel_submit
    authorize :admin_links, :show?
    file_entity = params.dig(:museum_objects, :excel_file)
    warnings = {}
    filename = file_entity.original_filename
    if !correct_file_format?(file_entity, ".xls") && !correct_file_format?(file_entity, ".xlsx")
      warnings[filename.to_sym] =
        file_entity.original_filename + ": " + t('unsupported_file_format_detected_only_xls_and_xlsx_files_are_supported')
      flash[:warning] = warnings
      redirect_to import_museum_objects_from_excel_select_path
    end

    timestamp = DateTime.now.strftime("%Y-%m-%d %H:%M:%S:%L")
    filename = timestamp + " translation import.log"
    log_path = "#{Rails.root}/log/" + filename
    session[:log_path] = log_path
    logger = ActiveSupport::TaggedLogging.new(Logger.new(log_path))
    MuseumObjectExcelImportService.import_from_file file_entity, log_path
    redirect_to import_museum_objects_from_excel_select_path
  end

  def import_termlists_submit
    authorize :admin_links, :show?
    files = params.dig(:termlists, :termlist_files)

    timestamp = DateTime.now.strftime("%Y-%m-%d %H:%M:%S:%L")
    filename = timestamp + "termlist import.log"
    log_path = "#{Rails.root}/log/" + filename
    session[:log_path] = log_path
    logger = ActiveSupport::TaggedLogging.new(Logger.new(log_path))

    files.each do |file|
      begin
        data = FileImportHelper.termlist_to_hash file
        if data.has_key?("museum") && data.has_key?("storages")
          StaticPagesHelper.import_museum_data data
        elsif data.has_key?("site_name")
          StaticPagesHelper.import_site_names data
        else
          import_errors = FileImportHelper.import_and_remove(data)
          logger.tagged(file.original_filename){logger.warn import_errors} unless import_errors.empty?
        end
      rescue StandardError => e
        STDERR.puts e
        filename = file.original_filename
        flash[:danger] ||= {}
        flash[:danger][filename] = 'skipped file because of error: ' + file.original_filename
      end
    end
    if flash[:danger].nil?
      flash[:success] = I18n.t('import complete')
    end
    redirect_to import_termlists_select_path
  end

  private
  # ToDo: Do not remove 'undetermiend' paths
  def remove_non_existent_paths data
    material_specified = MaterialSpecified.find_by name_en: data["material_specifieds"]
    m_id = Material.find_by(name_en: data["material_name"]).id
    ms_id = material_specified.id
    ms_path = Path.find_by(path: "/#{m_id}/#{ms_id}")
    existing_pathnames = ms_path.transitive_children.depth(4).map(&:path)
    imported_pathnames = []
    data["kind_of_objects"].each do |koo_hash|
      koo_id = KindOfObject.find_by(name_en: koo_hash.keys.first).id
      koo_hash.values.flatten.each do |koos|
        koos_id = KindOfObjectSpecified.find_by(name_en: koos).id
        imported_pathnames << "/#{m_id}/#{ms_id}/#{koo_id}/#{koos_id}"
      end
    end
    remove_pathnames = existing_pathnames - imported_pathnames
    Path.where(path: remove_pathnames).destroy_all
  end

  def import_materials data
    materials_for_import = []
    materials_for_import, warnings =
      parse_import_files params.dig(:termlists, :termlist_files)
    material_attributes = [
      :material_name,
      :material_specifieds,
      :kind_of_objects,
      :production_techniques,
      :decorations,
      :colors,
      :decoration_colors,
      :decoration_techniques,
      :preservation_materials,
      :preservation_objects
    ]
    log_files = []
    materials_for_import&.each do |material_hash|
      log_files << material_import(material_hash, material_attributes)
    end
    flash[:warning] = warnings
    if materials_for_import.present?
      flash[:success][:file_import] = materials_for_import.count.to_s + " " + t('files_uploaded')
    end
  end

  def correct_file_format? file_entity, format_string
    return File.extname(file_entity.tempfile) == format_string
  end
end
