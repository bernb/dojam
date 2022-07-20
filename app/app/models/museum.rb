class Museum < ApplicationRecord
  has_many :storages, dependent: :restrict_with_error
  has_many :users, dependent: :restrict_with_error
end
