class ProductionTechnique < Termlist
  has_many :production_technique_museum_objects
  has_many :museum_objects,
           through: :production_technique_museum_objects,
           dependent: :restrict_with_error
end
