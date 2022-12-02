class InscriptionLetter < Termlist
  has_many :inscription_letter_museum_objects
  has_many :museum_objects, through: :inscription_letter_museum_objects, dependent: :restrict_with_error
	def self.is_independent_of_paths
		true
	end
end
