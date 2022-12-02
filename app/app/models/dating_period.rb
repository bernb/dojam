class DatingPeriod < Termlist
  has_many :museum_objects, dependent: :restrict_with_error
	acts_as_list scope: [:type]
	def self.is_independent_of_paths
		true
	end
end
