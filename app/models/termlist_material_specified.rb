class TermlistMaterialSpecified < ApplicationRecord
  belongs_to :termlist_material
  has_many :join_museum_object_material_specifieds
  has_many :museum_objects, through: :join_museum_object_material_specifieds
  has_many :termlist_kind_of_objects
  has_many :termlist_productions
  has_many :termlist_colors
  has_many :termlist_decorations
  has_many :termlist_decoration_colors
  has_many :termlist_inscription_letters
end
