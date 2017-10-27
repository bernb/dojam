class TermlistDecoration < ApplicationRecord
  has_many :museum_objects
  belongs_to :termlist_material_specified
end
