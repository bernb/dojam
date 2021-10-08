class Museum < ApplicationRecord
  has_many :storages
  has_many :users
end
