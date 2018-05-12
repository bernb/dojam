class JoinMuseumObjectColor < ApplicationRecord
  belongs_to :termlist_color, inverse_of: :join_museum_object_colors
  belongs_to :museum_object, inverse_of: :join_museum_object_colors
end
