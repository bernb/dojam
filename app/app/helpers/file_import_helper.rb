module FileImportHelper

  def self.import_and_remove data
    FileImportHelper.create_new_terms data
    FileImportHelper.create_non_leaf_paths data
    given_pathnames = FileImportHelper.hash_to_pathnames data
    ms_path = FileImportHelper.material_specified_path data
    old_pathnames = ms_path.leafs.map(&:path)
    remove_pathnames = old_pathnames - given_pathnames
    new_pathnames = given_pathnames - old_pathnames
    new_pathnames.map!{|p_name| {path: p_name}}
    Path.create new_pathnames
    # We only catch errors that occur because there are still museum objects associated
    errors = Path.destroy_by(path: remove_pathnames)
      .select{|p| p.errors.any?}
      .to_h{|p| [p.named_path,
                 [p.museum_objects.map(&:id),
                  p.museum_objects_as_main.map(&:id)]
                   .flatten]}
    self.humanize_errors errors
  end

  def self.termlist_to_hash file
    errors = {}
    begin
      data = YAML.safe_load file.read
    rescue Psych::SyntaxError => se
      line_number = se.message.match(/line (\d+)/).captures[0]
      errors[:file] = file_entity.original_filename + " " + t('line') + " " + line_number.to_s + ': ' + t('syntax_error_in_file_please_check_the_file_for_errors_and_try_again')
    rescue Psych::DisallowedClass => se
      errors[:file] = file_entity.original_filename + ': ' + t('syntax_error_in_file_please_check_the_file_for_errors_and_try_again')
    end
    return data
  end

  private

  def self.humanize_errors errors
    return [] unless errors.present?
    errors_h = []
    errors_h << 'Could not remove terms because they are still referenced by museum objects:'
    errors.each do |path, objects_ids|
      inv_numbers = objects_ids.map{|id| MuseumObject.find id}.map(&:decorate).map(&:full_inv_number)
      errors_h << path + ": " + inv_numbers.to_s
    end
    errors_h.join("\n")
  end

  def self.material_specified_path data
    material = Material.find_by name_en: data["material_name"]
    material_specified = MaterialSpecified.find_by name_en: data["material_specified"]
    return Path.find_by(path: "/#{material.id}/#{material_specified.id}")
  end

  def self.create_new_terms data
    Material.find_or_create_by name_en: data["material_name"]
    MaterialSpecified.find_or_create_by name_en: data["material_specified"]
    data["kind_of_objects"].each do |kind_of_object_hash|
      kind_of_object_name = kind_of_object_hash.keys.first
      KindOfObject.find_or_create_by name_en: kind_of_object_name
      kind_of_object_hash[kind_of_object_name].each do |kind_of_object_specified_name|
        KindOfObjectSpecified.find_or_create_by name_en: kind_of_object_specified_name
      end
    end
  end

  def self.create_non_leaf_paths data
    material = Material.find_by name_en: data["material_name"]
    Path.find_or_create_by path: "/#{material.id}"

    material_specified = MaterialSpecified.find_by name_en: data["material_specified"]
    Path.find_or_create_by path: "/#{material.id}/#{material_specified.id}"

    data["kind_of_objects"].each do |kind_of_object_hash|
      kind_of_object_name = kind_of_object_hash.keys.first
      kind_of_object = KindOfObject.find_by name_en: kind_of_object_name
      Path.find_or_create_by path: "/#{material.id}/#{material_specified.id}/#{kind_of_object.id}"
    end
  end

  def self.hash_to_pathnames data
    paths = []
    material = Material.find_by name_en: data["material_name"]
    material_specified = MaterialSpecified.find_by name_en: data["material_specified"]

    data["kind_of_objects"].each do |kind_of_object_hash|
      kind_of_object_name = kind_of_object_hash.keys.first
      kind_of_object = KindOfObject.find_or_create_by name_en: kind_of_object_name

      kind_of_object_hash[kind_of_object_name].each do |kind_of_object_specified_name|
        kind_of_object_specified = KindOfObjectSpecified.find_by name_en: kind_of_object_specified_name
        paths << "/#{material.id}/#{material_specified.id}/#{kind_of_object.id}/#{kind_of_object_specified.id}"
      end
    end
    return paths
  end
end