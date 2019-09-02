class Authenticity < Termlist
  has_many :museum_objects
	def self.is_independent_of_paths
		true
	end
end
