class TermlistColor < ApplicationRecord
  include BeforeCreateAddAllKindOfObjectSpecifieds
  has_many :join_museum_object_colors, inverse_of: :termlist_color
  has_many :museum_objects, through: :join_museum_object_colors
  has_many :colors_ms_koo_specs
	has_many :material_specifieds_koo_specs, through: :colors_ms_koo_specs
  has_many :termlist_kind_of_object_specifieds, through: :material_specifieds_koo_specs
	has_many :termlist_material_specifieds, through: :material_specifieds_koo_specs
end 
