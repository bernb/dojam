class TermlistColor < ApplicationRecord
  has_many :join_museum_object_colors
  has_many :museum_objects, through: :join_museum_object_colors
  has_many :termlist_kind_of_object_specifieds_color
  has_many :termlist_kind_of_objects, through: :termlist_kind_of_object_specifieds_color
end 
