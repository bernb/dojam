class TermlistKindOfObjectSpecified < ApplicationRecord
	alias_attribute :props, :material_specifieds_koo_specs
  belongs_to :termlist_kind_of_object, required: false
  has_many :museum_objects
	has_many :material_specifieds_koo_specs
	has_many :termlist_material_specifieds, through: :material_specifieds_koo_specs do
		# We enforce uniqueness of join table on database level
		# So we avoid UniquenessViolation by altering the often used shovel operator
		def << (value)
			super value unless self.include? value
		end
	end
	has_many :colors_ms_koo_specs, through: :material_specifieds_koo_specs
  has_many :termlist_colors, through: :colors_ms_koo_specs
	has_many :prod_techs_ms_koo_specs, through: :material_specifieds_koo_specs
	has_many :termlist_production_techniques, through: :prod_techs_ms_koo_specs

	def insert_properties property_name, properties
		prop_method = property_name.to_s 
		# Better safe than sorry: We are very restrictive when using send
		return nil unless /termlist_[a-z]+/.match?(prop_method) && self.props.first.respond_to?(prop_method.to_s)
		self.props.each do |join_entry|
			# only add if association does not exist already
			join_entry.send(prop_method).find_by(id: properties.id) || join_entry.send(prop_method) << properties
		end
	end


end
