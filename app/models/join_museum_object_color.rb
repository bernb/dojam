class JoinMuseumObjectColor < ApplicationRecord
  belongs_to :termlist_color, required: false
  belongs_to :museum_object, required: false
end
