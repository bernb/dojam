def material_import material_hash
	termlist_paths_columns = [:termlist_id, :path_id]
	termlist_paths = []
	endpoint_paths = []


	material = Material.find_or_create_by name: material_hash[:material_name]
	path = Path.find_or_create_by path:  "/#{material.id.to_s}"
	termlist_paths << [material.id, path.id]

	ms_ids = []
	material_hash[:material_specifieds].push("undetermined").each do |material_specified_name|
		ms = MaterialSpecified.find_or_create_by name: material_specified_name
		path = Path.find_or_create_by path: "/#{material.id.to_s}/#{ms.id.to_s}"
		termlist_paths << [ms.id, path.id]
		ms_ids << ms.id # Used in next step by kind of objects
	end
	
	material_hash[:kind_of_objects].push("undetermined").each do |kind_of_object_name|
		koo_hash = nil
		koo = nil
		if kind_of_object_name.is_a? Hash
			koo_hash = kind_of_object_name
			kind_of_object_name = koo_hash.keys.first
			koo = KindOfObject.find_or_create_by name: kind_of_object_name
			koo_hash.values[0].push("undetermined").each do |koos_name|
				koos = KindOfObjectSpecified.find_or_create_by name: koos_name
				path_names = ms_ids.map{|ms_id| "/#{material.id}/#{ms_id.to_s}/#{koo.id.to_s}/#{koos.id.to_s}"}
				paths = path_names.map{|p| Path.find_or_create_by path: p}
				endpoint_paths += paths
				paths.each{|p| termlist_paths << [koos.id, p.id]}
			end
		else
			koo = KindOfObject.find_or_create_by name: kind_of_object_name
		end
		path_names = ms_ids.map{|ms_id| "/#{material.id}/#{ms_id.to_s}/#{koo.id.to_s}"}
		paths = path_names.map{|p| Path.find_or_create_by path: p}
		endpoint_paths += paths
		paths.each{|p| termlist_paths << [koo.id, p.id]}
	end

	rejects = [:material_name, :material_specifieds, :kind_of_objects]
	material_hash.keys.reject{|name| name.in?(rejects)}.each do |termlist_name|
		termlist_class = termlist_name.to_s.camelize.singularize.constantize
		new_termlists = material_hash[termlist_name].push("undetermined").map{|tname| termlist_class.find_or_create_by name: tname}
		new_termlist_ids = new_termlists.map(&:id)
		endpoint_paths.map{|p| new_termlists.map{|t| termlist_paths << [t.id, p.id]}}
	end

	Rails.logger.info " Import #{termlist_paths.size} paths now"
	# Note for example path for metal (material) will show up several times if for example
	# Two files specifying two material specified for metal exist
	TermlistPath.import termlist_paths_columns, termlist_paths, validate: false, on_duplicate_key_ignore: true
end
