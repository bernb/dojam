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

  def import_termlists_select
  end

  def import_termlists_submit
    file_hash = params.dig(:termlists, :termlist_files)
    determine_termlist_type file_hash
    import_materials
    redirect_to import_termlists_select_path
  end

  private
  def determine_termlist_type file_hash
    warnings = {}
    file_hash&.each do |file_entity|
      filename = file_entity.original_filename
      if !correct_file_format?(file_entity)
        warnings[filename.to_sym] = 
          "#{file_entity.original_filename}: Unsupported file format detected. Only yaml files are supported."
        next
      end
      file = File.open file_entity.tempfile
      data = YAML.safe_load file.read
      if data.keys.include?("material_name")
        import_materials
      elsif data.keys.include?("museum")
        #import_museum_data
      end
    end
  end

  def import_materials
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
      flash[:success] = "Uploaded #{materials_for_import.count} files"
    end
  end

  def correct_file_format? file_entity
    return File.extname(file_entity.tempfile) == ".yaml"
  end
end
