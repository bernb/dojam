class Material < Termlist
	has_many :material_museum_objects
	has_many :museum_objects, through: :material_museum_objects
	def depth
		1
	end

	def material_specifieds
		# We query MaterialSpecified to get the default scope and therefore
		# correct order of results
		children_paths = self.paths.first.direct_children.map(&:path)
		material_specifieds = MaterialSpecified.joins(:paths).where(paths: {path: children_paths}) 
		return material_specifieds
	end
end
