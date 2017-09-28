class TermlistMaterial < ApplicationRecord
  has_many :join_table_museum_object_termlist_materials
  has_many :museum_objects, through: :join_table_museum_object_termlist_material
  has_many :termlist_material_specifieds
end
