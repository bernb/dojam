class StorageLocation < ApplicationRecord
  translates :name
  acts_as_list scope: :storage
  default_scope {order(:position)}
  has_many :museum_objects, dependent: :restrict_with_error
  belongs_to :storage
  delegate :museum, to: :storage
end
