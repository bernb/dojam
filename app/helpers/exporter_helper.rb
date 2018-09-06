module ExporterHelper
	require 'awesome_print'

	def self.call material
		h = Hash.new
		h[:material] = material.name
		material_specified_ids = material.paths.first.direct_children.map(&:ids).map(&:second)
		material_specifieds = MaterialSpecified.find(material_specified_ids)
		h[:material_specifieds] = material_specifieds.map(&:name)
		kind_of_objects = material_specifieds.map(&:kind_of_objects).flatten.uniq
		h[:kind_of_objects] = kind_of_objects.map(&:name)
		kind_of_objects.each do |koo|
			koos = koo.kind_of_object_specifieds(material_specified: material_specifieds.first).reject{|k| k.name == "undetermined"}
			if koos.present?
				koos_hash = Hash.new
				koos_hash[koo.name] = koos.map(&:name)
				h[:kind_of_objects].delete koo.name
				h[:kind_of_objects] << koos_hash
			end
		end



		ap h
	end

end
