class Material < Termlist
	has_many :material_museum_objects
	has_many :museum_objects, through: :material_museum_objects
	def depth
		1
	end

	def material_specifieds
		material_specifieds = []
		self.paths.first.direct_children.each do |child|
			material_specifieds << child.objects[1]
		end
		return material_specifieds
	end
end
