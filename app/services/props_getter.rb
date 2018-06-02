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
		elsif termlist_material_specified.present? && termlist_kind_of_object.present?
			Rails.logger.debug "**** Props getter: ms/koo selection ****"
			# Just to make the query a bit more clear
			m_spec_id = termlist_material_specified.id
			koo_id = termlist_kind_of_object.id
			class_name.joins(material_specifieds_koo_specs: 
											 [{termlist_kind_of_object_specified: :termlist_kind_of_object}, 
												{termlist_material_specified: :termlist_material}])
				.where(material_specifieds_koo_specs: 
								{termlist_kind_of_object_specifieds: 
									{termlist_kind_of_objects: 
										{id: koo_id}}})
				.where(material_specifieds_koo_specs: 
					{termlist_material_specifieds: 
						{id: m_spec_id}})
				.distinct
		end
	end
end
