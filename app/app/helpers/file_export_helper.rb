module FileExportHelper

  def self.call
    m = Material.find_by name_en: "stone/mineral"
    zipbuffer = Zip::OutputStream::write_buffer do |zip|
      m.material_specifieds.each do |ms|
        ms_hash = material_specified_to_hash ms
        path_dependent_term_hash = path_dependent_terms_to_hash ms
        file_data = YAML.dump ms_hash.merge(path_dependent_term_hash)
        ms_name = ms.name_en.tr('/', '_').gsub(/[^\w_]/, '')
        m_name = m.name_en.tr('/', '_').gsub(/[^\w_]/, '')
        zip.put_next_entry(m_name + '/' + ms_name + '.yaml')
        zip.write(file_data)
      end
    end
    zipbuffer.string
  end

  private

  def self.path_dependent_terms_to_hash ms
    term_hash = {}
    # ToDo: Why is rejecting koos neccessary?
    term_types = Termlist.existing_typenames.reject{|t| t == "KindOfObjectSpecified"}
    leaf = ms.paths.first.leafs.first
    term_types.each do |term_type|
      external_name = Termlist.to_external_type(term_type).underscore.pluralize
      terms = term_type.constantize.for_path(leaf).map(&:name_en).sort do |a, b|
        if a == 'undetermined'
          1
        elsif b == 'undetermined'
          -1
        else
          a <=> b
        end
      end
      term_hash[external_name] = terms unless terms.empty?
    end
    term_hash
  end

  # We use a format that's simple as a file on the cost of a bit complex format used internally:
  # ms_hash["kind_of_objects"] is an array of hashes, those hashes only have a single key with an array as value
  # The result looks like this:
  # ...
  # kind_of_objects:
  #   - sculpture:
  #     - bust
  #     - head
  #   - vessel:
  #     - reiquary
  # ...
  def self.material_specified_to_hash ms
    ms_hash = {}
    ms_hash["material_name"] = ms.material.name_en
    ms_hash["material_specified"] = ms.name_en
    ms_hash["kind_of_objects"] = []
    ms_path = ms.paths.first
    ms_path.direct_children.each do |koo_path|
      # ToDo: Check result if language is set to arabic
      koo_name = koo_path.last_object_name
      koo_hash = {}
      koos_array = []
      koo_path.direct_children.each do |koos_path|
        koos_array << koos_path.last_object_name
      end
      koo_hash[koo_name] = koos_array
      ms_hash["kind_of_objects"] << koo_hash
    end
    ms_hash
  end

  def hash_to_file data

  end
end