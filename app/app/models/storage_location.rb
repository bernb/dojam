class StorageLocation < ApplicationRecord
  translates :name
  has_many :museum_objects
  belongs_to :storage
  delegate :museum, to: :storage
end
