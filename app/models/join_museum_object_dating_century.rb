class JoinMuseumObjectDatingCentury < ApplicationRecord
  belongs_to :museum_object, required: false
  belongs_to :termlist_dating_century, required: false
end
