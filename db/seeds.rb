Dir["#{Rails.root}/db/data/*.rb"].reject{|file| file.include?("test") || file.include?("general") }.each {|file| require file}
require "#{Rails.root}/db/data/general_data.rb"
require "#{Rails.root}/db/data/material_test.rb"


def termlist_names data, all = false
	if all
		data.keys
	else
		data.keys.reject{|var| var.to_s.starts_with?("material") || var.to_s.starts_with?("kind_of_object")}
	end
end


def new_import material_hash
	termlist_paths_columns = [:termlist_id, :path_id]
	termlist_paths = []
	endpoint_paths = []


	material = Material.find_or_create_by name: material_hash[:material_name]
	path = Path.find_or_create_by path:  "/#{material.id.to_s}"
	termlist_paths << [material.id, path.id]

	ms_ids = []
	material_hash[:material_specifieds].each do |material_specified_name|
		ms = MaterialSpecified.find_or_create_by name: material_specified_name
		path = Path.find_or_create_by path: "/#{material.id.to_s}/#{ms.id.to_s}"
		termlist_paths << [ms.id, path.id]
		ms_ids << ms.id # Used in next step by kind of objects
	end
	
	material_hash[:kind_of_objects].each do |kind_of_object_name|
		koo_hash = nil
		if kind_of_object_name.is_a? Hash
			koo_hash = kind_of_object_name
			kind_of_object_name = koo_hash.keys.first
			koo = KindOfObject.find_or_create_by name: kind_of_object_name
			koo_hash.values[0].each do |koos_name|
				koos = KindOfObjectSpecified.find_or_create_by name: koos_name
				path_names = ms_ids.map{|ms_id| "/#{material.id}/#{ms_id.to_s}/#{koo.id.to_s}/#{koos.id.to_s}"}
				paths = path_names.map{|p| Path.find_or_create_by path: p}
				endpoint_paths += paths
				paths.each{|p| termlist_paths << [koos.id, p.id]}
			end
		else
			koo = KindOfObject.find_or_create_by name: kind_of_object_name
			path_names = ms_ids.map{|ms_id| "/#{material.id}/#{ms_id.to_s}/#{koo.id.to_s}"}
			paths = path_names.map{|p| Path.find_or_create_by path: p}
			endpoint_paths += paths
			paths.each{|p| termlist_paths << [koo.id, p.id]}
		end
	end

	rejects = [:material_name, :material_specifieds, :kind_of_objects]
	material_hash.keys.reject{|name| name.in?(rejects)}.each do |termlist_name|
		termlist_class = termlist_name.to_s.camelize.singularize.constantize
		new_termlists = material_hash[termlist_name].push("undetermined").map{|tname| termlist_class.find_or_create_by name: tname}
		new_termlist_ids = new_termlists.map(&:id)
		endpoint_paths.map{|p| new_termlists.map{|t| termlist_paths << [t.id, p.id]}}
	end

	Rails.logger.info " Import #{termlist_paths.size} paths now"
	TermlistPath.import termlist_paths_columns, termlist_paths, validate: false
end




def build_termlists data, path
	p = Path.find_or_initialize_by path: path
	termlist_names(data).each do |termlist|
		classname = termlist.to_s.classify.constantize
		data[termlist].each do |name|
			t = classname.find_or_initialize_by name: name
			t.paths << p
		end
		# Create undetermined entry by default
		# This was too slow and made termlist_paths table 2,5 the size it was so we now
		# merge undetermined entries within the museum_object model when getting possible properties
		 undetermined_entry = classname.find_or_initialize_by name: "undetermined"
		 undetermined_entry.paths << p
	end
end

def import_material data 
	if data[:material_name].empty?
		Rails.logger.error "*** No material given with data hash. ***"
		Rails.logger.error "Given data hash: " + data.to_s
		return
	end
	paths = []
	material = Material.find_or_initialize_by(name: data[:material_name])
	# ToDo: Test if even needed at the moment
	path = Path.find_or_initialize_by path: "/#{material.id}"
	material.paths << path
	data[:material_specifieds].each do |ms_name|
		material_specified = MaterialSpecified.find_or_initialize_by name: ms_name
		Path.find_or_initialize_by path: "/#{material.id}/#{material_specified.id}"
		data[:kind_of_objects].each do |koo_name|
			# if entry is hash, kind of object specifieds are present
			if koo_name.is_a? Hash
				koo = KindOfObject.find_or_initialize_by name: koo_name.keys[0].to_s
				material_specified.attach_child koo
				koo_name.values[0].each do |koos_name|
					koos = KindOfObjectSpecified.find_or_initialize_by name: koos_name
					# Note: here is the error, this iterates over ALL koo paths and attach /*/*/*/koos.id which is wrong
					koo.attach_child koos
					path = PathGetter.call material: material, material_specified: material_specified, kind_of_object: koo, kind_of_object_specified: koos
					build_termlists data, path
				end # koos	
			else # if not hash
				koo = KindOfObject.find_or_initialize_by name: koo_name
				material_specified.attach_child koo
				path = PathGetter.call material: material, material_specified: material_specified, kind_of_object: koo
				build_termlists data, path
			end # if not hash
			undetermined_koos = KindOfObjectSpecified.find_or_initialize_by name: "undetermined"
			koo.attach_child undetermined_koos

		end # each kind of object
	end # each material specified

end
 
Rails.logger.info "*** Starting termlist import ***"
global_variables.select{|var| var.to_s.ends_with? "_data"}
								.reject{|var| var.to_s.include? "test"}
								.each do |material_data|
	Rails.logger.info "Importing variable " + material_data.to_s
	# Eval as material_data is given as a symbol
	new_import eval(material_data.to_s)
#	import_material eval(material_data.to_s)
#	import_dating_data
end
Rails.logger.info "*** Finished termlist import ***"
# import_material $test_data
