class PropsGetter

	def self.call(termlist_material_specified: nil, termlist_kind_of_object_specified: nil, termlist_kind_of_object: nil, property_name: nil)
		class_name = Object.const_get(property_name)
		if termlist_material_specified.present? && termlist_kind_of_object_specified.present?
			class_name.joins(:material_specifieds_koo_specs)
				.where(termlist_material_specified: termlist_material_specified)
				.where(termlist_kind_of_object_specified: termlist_kind_of_object_specified)
		elsif termlist_material_specified.present? && termlist_kind_of_object.present?
			class_name.joins(:material_specifieds_koo_specs)
				.where(material_specifieds_koo_specs: {termlist_material_specified: termlist_material_specified})
				.joins(:termlist_kind_of_object_specifieds)
				.where(termlist_kind_of_object_specifieds: {termlist_kind_of_object: termlist_kind_of_object}).distinct
		end
	end
end
