class PropsSetter
	def self.call property_name:, property:, koos:, material_specified:
		prop_method = property_name.to_s 
		# Better safe than sorry: We are very restrictive when using send
		return nil unless /termlist_[a-z]+/.match?(prop_method) && MaterialSpecifiedsKooSpec.respond_to?(prop_method.to_s)
		props = MaterialSpecifiedsKooSpec.where(termlist_kind_of_object_specified: koos).where(termlist_material_specified: material_specified)
		props.each do |join_entry|
			# only add if association does not exist already
			join_entry.send(prop_method).find_by(id: property.id) || join_entry.send(prop_method) << property
		end
	end
end
