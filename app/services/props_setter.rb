class PropsSetter
	def self.call property_name:, property:, koos:, material_specified:
		# Method accepts arrays as well as objects for koos and material_specified
		# Check if array and remove empty entries, so that [""] becomes [] i.e. empty
		if koos.is_a? Array
			koos = koos.reject{|k| k.empty?}
		end
		if material_specified.is_a? Array
			material_specified = material_specified.reject{|m| m.empty?}
		end

		prop_method = property_name.to_s 
		Rails.logger.debug "Called for prop method " + prop_method
		# Better safe than sorry: We are very restrictive when using send
		# We assume at least one single MaterialSpecifiedsKooSpec entry
		return nil unless /termlist_[a-z_]+/.match?(prop_method) && MaterialSpecifiedsKooSpec.first.respond_to?(prop_method.to_s)
		props = [] # Initialize empty to do nothing if neither koos nor material_specified is given
		if koos.present?
			props = MaterialSpecifiedsKooSpec.where(termlist_kind_of_object_specified: koos)
			if material_specified.present?
				props = props.where(termlist_material_specified: material_specified)
			end
		elsif material_specified.present?
			props = MaterialSpecifiedsKooSpec.where(termlist_material_specified: material_specified)
		end

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
