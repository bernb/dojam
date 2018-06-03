class TermlistMaterial < ApplicationRecord
  has_many :termlist_material_specifieds
  has_many :termlist_kind_of_objects, ->{distinct}, through: :termlist_material_specifieds
  has_many :termlist_kind_of_object_specifieds, ->{distinct},  through: :termlist_kind_of_objects
	has_many :termlist_production_techniques, ->{distinct}, through: :termlist_material_specifieds
end
