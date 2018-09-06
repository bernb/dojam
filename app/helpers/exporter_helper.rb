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



		ap h
	end

end
