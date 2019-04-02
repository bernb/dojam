class MaterialSpecified < Termlist
	def depth
		2
	end

	def material
		self.paths.first.objects[0]
	end

	def kind_of_objects
		# We query KindOfObject to get the default scope and therefore
		# correct order of results
		children_paths = self.paths.first.direct_children.map(&:path)
		kind_of_objects = KindOfObject.joins(:paths).where(paths: {path: children_paths})
		return kind_of_objects
	end
end
