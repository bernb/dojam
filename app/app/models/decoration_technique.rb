class DecorationTechnique < Termlist
  has_many :decoration_technique_museum_objects
  has_many :museum_objects, through: :decoration_technique_museum_objects
end
