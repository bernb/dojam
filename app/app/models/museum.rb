class Museum < ApplicationRecord
  has_many :storages, dependent: :restrict_with_error
  has_many :users, dependent: :restrict_with_error

  def museum_objects
    storages.map(&:museum_objects).flatten.uniq
  end
end
