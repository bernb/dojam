class PropsSetter
	def self.call property_name:, property:, koos:, material_specified:
		prop_method = property_name.to_s 
		Rails.logger.debug "Called for prop method " + prop_method
		# Better safe than sorry: We are very restrictive when using send
		# We assume at least one single MaterialSpecifiedsKooSpec entry
		return nil unless /termlist_[a-z_]+/.match?(prop_method) && MaterialSpecifiedsKooSpec.first.respond_to?(prop_method.to_s)
		props = MaterialSpecifiedsKooSpec.where(termlist_kind_of_object_specified: koos).where(termlist_material_specified: material_specified)
		props.each do |join_entry|
			# only add if association does not exist already
			Rails.logger.debug "**********"
			Rails.logger.debug "Search for existing results in: " + join_entry.send(prop_method).find_by(id: property.id)&.name.to_s
			Rails.logger.debug "join_entry: " + join_entry.to_s
			Rails.logger.debug "prop_method: " + prop_method.to_s
			Rails.logger.debug "property: " + property&.name
			join_entry.send(prop_method).find_by(id: property.id) || (join_entry.send(prop_method) << property)
		end
	end
end
