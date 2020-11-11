class Storage < ApplicationRecord
  translates :name
  belongs_to :museum
  has_many :storage_locations, dependent: :restrict_with_error
end
