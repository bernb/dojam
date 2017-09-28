class TermlistMaterialSpecified < ApplicationRecord
  belongs_to :termlist_material
  has_many :join_museum_object_material_specifieds
  has_many :museum_objects, through: :join_museum_object_material_specifieds
end
