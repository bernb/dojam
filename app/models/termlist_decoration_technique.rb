class TermlistDecorationTechnique < ApplicationRecord
  has_many :termlist_kind_of_object_specifieds_decoration_techniques, inverse_of: :termlist_decoration_technique
	has_many :material_specifieds_kind_of_object_specifieds, through: :termlist_kind_of_object_specifieds_decoration_techniques
  has_many :termlist_kind_of_object_specifieds, through: :material_specifieds_kind_of_object_specifieds
  has_many :museum_objects
end
