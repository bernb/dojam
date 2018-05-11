class MuseumObjectImageList < ApplicationRecord
  belongs_to :museum_object
  has_many_attached :list
  has_one_attached :main
end
