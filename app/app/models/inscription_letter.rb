class InscriptionLetter < Termlist
  has_many :inscription_letter_museum_objects
  has_many :museum_objects, through: :inscription_letter_museum_objects
	def self.is_independent_of_paths
		true
	end
end
