class Material < Termlist
	has_many :material_museum_objects
	has_many :museum_objects, through: :material_museum_objects
	def depth
		1
	end

	def material_specifieds
		direct_children
	end
end
