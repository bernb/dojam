class TermlistMaterial < ApplicationRecord
  has_many :termlist_material_specifieds
  has_many :termlist_preservation_states
end
