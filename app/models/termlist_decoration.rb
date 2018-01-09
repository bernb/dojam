class TermlistDecoration < ApplicationRecord
  has_many :museum_objects
  has_many :termlist_kind_of_object_specifieds_decorations
  has_many :termlist_kind_of_object_specified, through: :termlist_kind_of_object_specifieds_decorations
end
