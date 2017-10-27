class TermlistColor < ApplicationRecord
  has_many :join_museum_object_colors
  has_many :museum_objects, through: :join_museum_object_colors
  belongs_to :termlist_material_specified
end
