class TermlistPreservationState < ApplicationRecord
  belongs_to :termlist_material
  has_many :museum_objects
end
