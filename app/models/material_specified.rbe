class MaterialSpecified < Termlist
	def depth
		2
	end

	def material
		self.paths.first.objects[0]
	end

	def kind_of_objects
		kind_of_objects = []
		self.paths.first.direct_children.each do |child|
			kind_of_objects << child.objects[2]
		end
		return kind_of_objects
	end
end
