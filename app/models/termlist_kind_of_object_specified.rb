class TermlistKindOfObjectSpecified < ApplicationRecord
  belongs_to :termlist_kind_of_object, required: false
  has_many :museum_objects
  has_many :termlist_kind_of_object_specifieds_production_techniques
  has_many :termlist_production_techniques, through: :termlist_kind_of_object_specifieds_production_techniques
  has_many :termlist_kind_of_object_specifieds_decorations
  has_many :termlist_decorations, through: :termlist_kind_of_object_specifieds_decorations
end
