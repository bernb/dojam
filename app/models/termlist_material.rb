class TermlistMaterial < ApplicationRecord
  has_many :termlist_material_specifieds
  has_many :termlist_kind_of_objects, through: :termlist_material_specifieds
  has_many :termlist_kind_of_object_specifieds, through: :termlist_kind_of_objects
  has_many :termlist_preservation_states
end
