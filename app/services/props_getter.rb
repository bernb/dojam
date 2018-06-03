class PropsGetter

	def self.call(termlist_material_specified: nil, termlist_kind_of_object_specified: nil, termlist_kind_of_object: nil, property_name: nil)
		return nil unless property_name.class == String && property_name.starts_with?("Termlist") && /^[a-zA-Z_]+$/.match?(property_name)
		class_name = Object.const_get(property_name)
		# Select the correct entries in material_specifieds_koo_specs
		# Single entry if ms and koos is definied or when ms and koo is defined
		if termlist_kind_of_object_specified.present? && termlist_material_specified.present?
			ms_koo_specs = MaterialSpecifiedsKooSpec.where({termlist_kind_of_object_specified: termlist_kind_of_object_specified, termlist_material_specified: termlist_material_specified})
		elsif termlist_material_specified.present? && termlist_kind_of_object.present?
			ms_koo_specs = MaterialSpecifiedsKooSpec.joins(:termlist_kind_of_object_specified).where({termlist_material_specified: termlist_material_specified, termlist_kind_of_object_specifieds: {termlist_kind_of_object: termlist_kind_of_object}}).distinct
		end
		class_name.joins(:material_specifieds_koo_specs).merge(ms_koo_specs)
	end
end
