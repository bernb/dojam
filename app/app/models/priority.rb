class Priority < Termlist
  has_many :museum_objects, dependent: :restrict_with_error
	def self.is_independent_of_paths
		true
	end
end
