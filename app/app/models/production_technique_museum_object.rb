class ProductionTechniqueMuseumObject < ApplicationRecord
  belongs_to :museum_object
  belongs_to :production_technique
end
