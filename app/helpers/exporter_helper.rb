module ExporterHelper
	require 'awesome_print'

	def self.call
		relative_path = "exports/"
		termlists = []
		Material.all.each do |material|
		termlists << export_termlists(material)
		end
		general_termlists = export_general_termlists

		termlists.each do |termlist|
			File.open(relative_path + termlist["material"].gsub('/', '_') + ".txt", "w") {|file| file.write(termlist.to_yaml)}
		end
			File.open(relative_path + "general_termlists" + ".txt", "w") {|file| file.write(general_termlists.to_yaml)}
	end


	def export_general_termlists
		general_terms = Hash.new
		general_terms["storages"] = Hash.new
		Storage.all.map(&:name).each{|s| general_terms["storages"][s] = []}
		StorageLocation.all.map{|s| [s.name, s.storage.name]}.each do |pair|
			general_terms["storages"][pair.second] << pair.first
		end

		termlist_names = Termlist.all.map(&:type).uniq
		termlist_names.each do |termlist_name|
			termlist = termlist_name.constantize
			if termlist.is_independent_of_paths
				general_terms[termlist_name] = Termlist.where(type: termlist_name).uniq
			end
		end

		return general_terms
	end

	def export_termlists material
		h = Hash.new
		general_terms = Hash.new
		h["material"] = material.name
		material_specified_ids = material.paths.first.direct_children.map(&:ids).map(&:second)
		material_specifieds = MaterialSpecified.find(material_specified_ids)
		h["material_specifieds"] = material_specifieds.map(&:name)
		kind_of_objects = material_specifieds.map(&:kind_of_objects).flatten.uniq
		h["kind_of_objects"] = kind_of_objects.map(&:name)
		kind_of_objects.each do |koo|
			koos = koo.kind_of_object_specifieds(material_specified: material_specifieds.first).reject{|k| k.name == "undetermined"}
			if koos.present?
				koos_hash = Hash.new
				koos_hash[koo.name] = koos.map(&:name)
				h["kind_of_objects"].delete koo.name
				h["kind_of_objects"] << koos_hash
			end
		end
		
		# We produce one wrong entry with the sql queries
		h.delete("KindOfObject")

		# Build termlists now
		m_id = material.id
		ms_id = material_specified_ids.first
		koo_id = kind_of_objects.first.id
		termlist_names = Termlist.all.map(&:type).uniq
		termlist_names.each do |termlist_name|
			termlist = termlist_name.constantize
			if !termlist.is_independent_of_paths
				terms = termlist.joins(:paths).where("paths.path LIKE ?", "/#{m_id}/#{ms_id}/#{koo_id}%").where("name != ?", "undetermined").uniq
				h[termlist_name] = terms.map(&:name) unless terms.empty?
			end
		end

		return h
	end

end
