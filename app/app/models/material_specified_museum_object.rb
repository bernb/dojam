class MaterialSpecifiedMuseumObject < ApplicationRecord
  belongs_to :material_specified
  belongs_to :museum_object
end
