class MaterialMuseumObject < ApplicationRecord
  belongs_to :material
  belongs_to :museum_object
end
