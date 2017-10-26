class TermlistKindOfObject < ApplicationRecord
  belongs_to :termlist_material_specified, required: false
  has_many :museum_objects
  has_many :termlist_kind_of_object_specifieds
end
