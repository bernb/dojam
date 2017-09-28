class TermlistMaterial < ApplicationRecord
  has_many :museum_objects
  has_many :termlist_material_specifieds
end
