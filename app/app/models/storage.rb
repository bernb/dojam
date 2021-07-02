class Storage < ApplicationRecord
  translates :name
  acts_as_list
  belongs_to :museum
  has_many :storage_locations, dependent: :restrict_with_error

  def museum_objects
    storage_locations.map(&:museum_objects).flatten.uniq
  end
end
