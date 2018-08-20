class DatingCentury < Termlist
	acts_as_list scope: [:type]
	self.default_scopes = []
	default_scope {order(position: :asc)}
end
