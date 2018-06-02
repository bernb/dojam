class PropsGetter

	def self.call(termlist_material_specified: nil, termlist_kind_of_object_specified: nil, termlist_kind_of_object: nil, property_name: nil)
		return nil unless property_name.class == String && property_name.starts_with?("Termlist") && /^[a-zA-Z_]+$/.match?(property_name)
		class_name = Object.const_get(property_name)
		if termlist_kind_of_object_specified.present?
			koos_id = termlist_kind_of_object_specified.id
			Rails.logger.debug "**** Props getter: koos selection ****"
			Rails.logger.debug "class_name: " + class_name.to_s
			Rails.logger.debug "koos_id: " + koos_id.to_s
			class_name.joins(material_specifieds_koo_specs: :termlist_kind_of_object_specified)
				.where(material_specifieds_koo_specs: 
								{termlist_kind_of_object_specifieds: 
										{id: koos_id}})
				.distinct
		elsif termlist_kind_of_object.present?
			# Just to make the query a bit more clear
			koo_id = termlist_kind_of_object.id
			Rails.logger.debug "**** Props getter: koo selection ****"
			Rails.logger.debug "class_name: " + class_name.to_s
			Rails.logger.debug "koo_id: " + koo_id.to_s
			class_name.joins(material_specifieds_koo_specs: 
											 {termlist_kind_of_object_specified: :termlist_kind_of_object})
				.where(material_specifieds_koo_specs: 
								{termlist_kind_of_object_specifieds: 
									{termlist_kind_of_objects: 
										{id: koo_id}}})
				.distinct
		end
	end
end
