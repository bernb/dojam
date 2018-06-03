class TermlistMaterialSpecified < ApplicationRecord
	alias_attribute :props, :material_specifieds_koo_specs
  belongs_to :termlist_material
  has_many :join_museum_object_material_specifieds
  has_many :museum_objects, through: :join_museum_object_material_specifieds
	has_many :material_specifieds_koo_specs
  has_many :termlist_kind_of_object_specifieds, ->{distinct}, through: :material_specifieds_koo_specs do
		def << (value)
			super value unless self.include? value
		end
	end
	has_many :termlist_kind_of_objects, -> { distinct }, through: :termlist_kind_of_object_specifieds
	has_many :prod_techs_ms_koo_specs, through: :material_specifieds_koo_specs
	has_many :termlist_production_techniques, ->{distinct}, through: :material_specifieds_koo_specs

end
