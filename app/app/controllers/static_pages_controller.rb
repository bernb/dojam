class StaticPagesController < ApplicationController
  include TermlistsImporterHelper
  def menu
  end

  def reports
    @museum_objects = MuseumObject.order(created_at: :desc)
      .limit(10)
      .decorate
      .reject{|o| o.inv_number.blank?}
  end

  def import_translations_select
    if session[:log_path].present?
      @log_messages = File.read(session[:log_path])
      session[:log_path] = nil
    end
  end

  def import_translations_submit
    file_entity = params.dig(:translations, :translation_file)
    warnings = {}
    filename = file_entity.original_filename
    if !correct_file_format?(file_entity, ".xls") && !correct_file_format?(file_entity, ".xlsx")
      warnings[filename.to_sym] = 
        file_entity.original_filename + ": " + I18n.t('Unsupported file format detected. Only .xls and .xlsx files are supported')
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
      name_en = row.first.strip
      name_ar = row.second.strip
      term = Termlist.where name_en: name_en
      if term.blank?
        logger.tagged("Row #{i.to_s}", "Skipped"){logger.warn "Term '#{name_en}' not found."}
        warnings[:skipped] = I18n.t('some rows were skipped, see below for more information')
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
      flash[:success] = I18n.t('translations successfully imported')
    else
      flash[:warning] = warnings
    end
    redirect_to import_translations_select_path
  end

  def import_termlists_select
  end

  def import_termlists_submit
    file_hash = params.dig(:termlists, :termlist_files)
    warnings = {}
    file_hash&.each do |file_entity|
      filename = file_entity.original_filename
      if !correct_file_format?(file_entity, ".yaml")
        warnings[filename.to_sym] = 
          file_entity.original_filename + ": " + I18n.t('Unsupported file format detected. Only yaml files are supported')
        next
      end
      file = File.open file_entity.tempfile
      begin
        data = YAML.safe_load file.read
      rescue Psych::SyntaxError => se
        line_number = se.message.match(/line (\d+)/).captures[0]
        warnings[filename.to_sym] = file_entity.original_filename + ": " + I18n.t('Syntax Error around line') + " " + line_number + ". " + I18n.t('Please check the file for errors and try again')
        next
      end
      if data.keys.include?("material_name")
        import_materials data
      elsif data.keys.include?("museum")
        helpers.import_museum_data data
      elsif data.keys.include?("site_name")
        helpers.import_site_names data
      end
    end
    flash[:warning] = warnings
    if flash[:danger].blank? && flash[:warning].blank?
      flash[:success] = I18n.t('data successfully imported')
    end
    redirect_to import_termlists_select_path
  end

  private
  def import_materials data
    flash[:warning] = Hash.new
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
      flash[:success] = materials_for_import.count + " " + I18n.t('file(s) uploaded')
    end
  end

  def correct_file_format? file_entity, format_string
    return File.extname(file_entity.tempfile) == format_string
  end
end
