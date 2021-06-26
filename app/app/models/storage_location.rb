class StorageLocation < ApplicationRecord
  translates :name
  has_many :museum_objects, dependent: :restrict_with_error
  belongs_to :storage
  delegate :museum, to: :storage
end
