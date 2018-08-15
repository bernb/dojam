class Material < Termlist
	def depth
		1
	end

	def material_specifieds
		direct_children
	end
end
