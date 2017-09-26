class StorageLocation < ApplicationRecord
  belongs_to :storage
  delegate :museum, to: :storage
end
