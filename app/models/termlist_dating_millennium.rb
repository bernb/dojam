class TermlistDatingMillennium < ApplicationRecord
  acts_as_list 
  has_many :museum_objects
  default_scope { order(position: :asc) }
end
