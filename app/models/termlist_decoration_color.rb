class TermlistDecorationColor < ApplicationRecord
  has_many :termlist_kind_of_object_specifieds_decoration_colors
  has_many :termlist_kind_of_object_specifieds, through: :termlist_kind_of_object_specifieds_decoration_colors
  has_many :museum_objects
end
