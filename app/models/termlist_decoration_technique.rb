class TermlistDecorationTechnique < ApplicationRecord
  belongs_to :termlist_kind_of_object_specified
  has_many :museum_objects
end
