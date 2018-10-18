class DatingPeriod < Termlist
	acts_as_list scope: [:type]
	def self.is_independent_of_paths
		true
	end
end
