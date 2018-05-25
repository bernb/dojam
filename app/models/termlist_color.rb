class TermlistColor < ApplicationRecord
  include BeforeCreateAddAllKindOfObjectSpecifieds
  has_many :join_museum_object_colors, inverse_of: :termlist_color
  has_many :museum_objects, through: :join_museum_object_colors
  has_many :colors_koo_specs
  has_many :termlist_kind_of_object_specifieds, through: :colors_koo_specs
end 
