class TermlistKindOfObjectSpecified < ApplicationRecord
  belongs_to :termlist_kind_of_object, required: false
  has_many :museum_objects
end
