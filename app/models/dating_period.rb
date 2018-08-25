class DatingPeriod < Termlist
	acts_as_list scope: [:type]
	self.default_scopes = []
	default_scope {order(position: :asc)}
	def self.is_independent_of_paths
		true
	end
end
