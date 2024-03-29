module FileImportHelper
  @@path_terms = %w[material_name material_specified material_specifieds kind_of_objects]

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
    destroy_result = Path.destroy_by(path: remove_pathnames)
    errors = destroy_result_to_error_hash destroy_result
    # We might have paths of depth 3 without any children
    Path.depth(3).select{|p| p.direct_children.count == 0}.map(&:destroy)

    # Remove path dependent terms that are not in the list
    paths = ms_path.leafs
    create_path_dependent_terms data
    given_terms = path_dependent_terms_as_list data
    # Remove path association for old paths for terms that are not in the list
    paths.each do |path|
      terms = []
      data.except(*@@path_terms).each do |typename_file, termlist|
        typename = Termlist.to_internal_type(typename_file.titleize(downcase: false).remove(" ").singularize)
        terms << Termlist.where(type: typename, name_en: termlist)
      end
      terms = terms.flatten
      terms_to_remove = path.termlists - terms
      # We first catch all museum objects that are associated with the current path.
      # Then we catch all museum objects for the terms that will get removed.
      # The intersection of both are museum objects that would become invalid because they belong to a path that would
      # not have that term any more
      # This check is neccessary for paths that do not get removed themselve, but have associated terms that would get removed
      museum_objects_with_path = MuseumObject.where_path(path)
      still_referenced = terms_to_remove.map{|t| [t, museum_objects_with_path & t.museum_objects]}
                                        .reject{|_, object_list| object_list.empty?}
                                        .to_h
      term_errors = still_referenced.map{|t, objects| ["#{path.named_path} - #{t.name_en} (#{t.type})", objects.map(&:id)]}.to_h
      path.termlists = terms + still_referenced.keys
      errors = errors.merge(term_errors)
    end
    self.humanize_errors errors
  end

  def self.termlist_to_hash file
    errors = {}
    begin
      data = YAML.safe_load file.read
    end
    return data
  end

  private
  def self.destroy_result_to_error_hash destroy_result
    destroy_result
      .select{|p| p.errors.any?}
      .to_h{|p| [p.named_path,
                 [p.museum_objects.map(&:id),
                  p.museum_objects_as_main.map(&:id)]
                   .flatten]}
  end

  def self.path_dependent_terms_as_list data
    data.except(*@@path_terms).values
  end

  def self.create_path_dependent_terms data
    data.except(*@@path_terms).each do |typename_file, termlist|
      typename = Termlist.to_internal_type(typename_file.titleize(downcase: false).remove(" ").singularize)
      termlist.each do |term|
        Termlist.find_or_create_by type: typename, name_en: term
      end
    end
  end

  def self.humanize_errors errors
    return [] unless errors.present?
    errors_h = []
    errors_h << 'Could not remove terms because they are still referenced by museum objects:'
    errors.each do |path, objects_ids|
      inv_numbers = objects_ids.map{|id| MuseumObject.find id}.map(&:decorate).map(&:full_inv_number)
      errors_h << path.to_s + ": " + inv_numbers.to_s
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
    material.paths.find_or_create_by(path: "/#{material.id}")

    material_specified = MaterialSpecified.find_by name_en: data["material_specified"]
    material_specified.paths.find_or_create_by(path: "/#{material.id}/#{material_specified.id}")
    data["kind_of_objects"].each do |kind_of_object_hash|
      kind_of_object_name = kind_of_object_hash.keys.first
      kind_of_object = KindOfObject.find_by name_en: kind_of_object_name
      kind_of_object.paths.find_or_create_by(path: "/#{material.id}/#{material_specified.id}/#{kind_of_object.id}")
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