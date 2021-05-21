class PreservationMaterial < Termlist
  has_many :museum_objects, dependent: :restrict_with_error
end
