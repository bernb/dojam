class TermlistMaterialSpecified < ApplicationRecord
  belongs_to :termlist_material
  has_many :join_museum_object_material_specifieds
  has_many :museum_objects, through: :join_museum_object_material_specifieds
	has_many :material_specifieds_koo_specs
  has_many :termlist_kind_of_object_specifieds, through: :material_specifieds_koo_specs
	has_many :termlist_kind_of_objects, through: :termlist_kind_of_object_specifieds

end
