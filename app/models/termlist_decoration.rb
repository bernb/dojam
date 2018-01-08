class TermlistDecoration < ApplicationRecord
  has_many :museum_objects
  belongs_to :termlist_kind_of_object_specified
end
