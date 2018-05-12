class TermlistDatingCentury < ApplicationRecord
  has_many :join_museum_object_dating_centuries
  has_many :museum_objects, through: :join_museum_object_dating_centuries
  has_many :termlist_kind_of_object_specifieds_dating_centuries
  has_many :termlist_kind_of_object_specifieds, through: :termlist_kind_of_object_specifieds_dating_centuries
end
