class DatingPeriod < Termlist
  has_many :museum_objects
	acts_as_list scope: [:type]
	def self.is_independent_of_paths
		true
	end
end
