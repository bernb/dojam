module TermlistsImporterHelper
	def material_import material_hash, material_attributes
		log_filename = "termlist_import_" + DateTime.now.strftime('%Y-%m-%d_%H:%M:%S.%N') + ".log"
		log_dirname = "#{Rails.root}/log/termlist_imports/"
		log_path = log_dirname + log_filename
		Dir.mkdir(log_dirname) unless Dir.exist?(log_dirname)
		logger = ActiveSupport::TaggedLogging.new(Logger.new(log_path))
		termlist_paths_columns = [:termlist_id, :path_id]
		termlist_paths = []
		endpoint_paths = []


		material = Material.find_or_create_by name_en: material_hash[:material_name]
		logger.info "Import termlists for material \"#{material.name}\""
		path = Path.find_or_create_by path:  "/#{material.id.to_s}"
		termlist_paths << [material.id, path.id]

		ms_ids = []
		ms_count = MaterialSpecified.count
		material_hash[:material_specifieds].push("undetermined").each do |material_specified_name|
			ms = MaterialSpecified.find_or_create_by name_en: material_specified_name
			path = Path.find_or_create_by path: "/#{material.id.to_s}/#{ms.id.to_s}"
			termlist_paths << [ms.id, path.id]
			ms_ids << ms.id # Used in next step by kind of objects
		end
		dif = MaterialSpecified.count - ms_count
		logger.info "#{dif.to_s} new specified materials imported"

		koo_count = KindOfObject.count
		koos_count = KindOfObjectSpecified.count
		material_hash[:kind_of_objects].push("undetermined").each do |kind_of_object_name|
			koo_hash = {}
			koo = nil
			if kind_of_object_name.is_a? Hash
				koo_hash = kind_of_object_name
				kind_of_object_name = koo_hash.keys.first
			else
				# create dummy hash only containing a single key with an empty array, 
				# where we will push the undetermined entry into later
				koo_hash[kind_of_object_name] = []
			end
			koo = KindOfObject.find_or_create_by name_en: kind_of_object_name
			path_names = ms_ids.map{|ms_id| "/#{material.id}/#{ms_id.to_s}/#{koo.id.to_s}"}
			paths = path_names.map{|p| Path.find_or_create_by path: p}
			endpoint_paths += paths
			paths.each{|p| termlist_paths << [koo.id, p.id]}

			koo_hash.values[0].push("undetermined").each do |koos_name|
				koos = KindOfObjectSpecified.find_or_create_by name_en: koos_name
				path_names = ms_ids.map{|ms_id| "/#{material.id}/#{ms_id.to_s}/#{koo.id.to_s}/#{koos.id.to_s}"}
				paths = path_names.map{|p| Path.find_or_create_by path: p}
				endpoint_paths += paths
				paths.each{|p| termlist_paths << [koos.id, p.id]}
			end
		end
		dif_koo = KindOfObject.count - koo_count
		dif_koos = KindOfObjectSpecified.count - koos_count
		logger.info "#{dif_koo.to_s} new kind of objects imported"
		logger.info "#{dif_koos.to_s} new specified kind of objects imported"

		rejects = [:material_name, :material_specifieds, :kind_of_objects]
		material_attributes.reject{|name| name.in?(rejects)}.each do |termlist_name|
			termlist_class = termlist_name.to_s.camelize.singularize.constantize
			attributes = []
			attributes += material_hash[termlist_name] unless material_hash[termlist_name].blank?
			new_termlists = attributes.push("undetermined").map{|tname| termlist_class.find_or_create_by name_en: tname}
			new_termlist_ids = new_termlists.map(&:id)
			endpoint_paths.map{|p| new_termlists.map{|t| termlist_paths << [t.id, p.id]}}
		end

		tp_count = TermlistPath.count
		# Note for example path for metal (material) will show up several times if for example
		# Two files specifying two material specified for metal exist
		TermlistPath.import termlist_paths_columns, termlist_paths, validate: false, on_duplicate_key_ignore: true
		dif = TermlistPath.count - tp_count
		logger.info "#{dif.to_s} new paths imported"
		return log_path
	end

	def parse_import_files file_hash
		materials_for_import = []
		warnings = {}
    filename = nil # Make it available for rescue block
		file_hash&.each do |file_entity|
      filename = file_entity.original_filename
      if !correct_file_format?(file_entity, ".yaml")
        warnings[filename.to_sym] = 
          "#{file_entity.original_filename}: Unsupported file format detected. Only yaml files are supported."
        next
      end
      file = File.open file_entity.tempfile
      material_data = YAML.safe_load file.read
      if !valid_material_data?(material_data)
        forbidden_terms = forbidden_terms(material_data)
        warnings[filename.to_sym] = 
          "#{file_entity.original_filename}: Unknown term(s) #{forbidden_terms}. Only whitelisted terms are allowed."
        next
      end
      # We used symbols as keys in original termlist rb files
      # but it's a bit ugly in yaml files as additional colon would be
      # needed to achieve this
      material_data.transform_keys!(&:to_sym)
      materials_for_import << material_data
		end
		if materials_for_import.blank?
			warnings[:no_valid_files] = "No valid files for import found"
		end
    return materials_for_import, warnings
  rescue Psych::SyntaxError => e
    warnings[filename.to_sym] = "Syntax Error in File #{filename} " + e.message
    warnings[:general] = "Stopped import."
    return materials_for_import, warnings
	end

  def forbidden_terms material_data
    term_whitelist = [
      "material_name",
      "material_specifieds",
      "kind_of_objects",
      "production_techniques",
      "colors",
      "decoration_techniques",
      "decorations",
      "decoration_colors",
      "preservation_objects",
      "preservation_materials",
    ]
    return material_data.keys.reject{|k| k.in?(term_whitelist)}
  end

  def valid_material_data? material_data
    if forbidden_terms(material_data).blank?
      return true
    else
      return false
    end
	end

	def global_material_variables_array
		global_variables.select{|var| var.to_s.ends_with? "_material_data"}
			.reject{|var| var.to_s.include? "test"}
	end


	def find_all_attributes
		attributes = []
		global_material_variables_array.each do |material_data|
			material_variable = eval(material_data.to_s)
			attributes += material_variable.keys
		end
		return attributes.uniq
	end
end
