class ExcavationSiteCategory < Termlist
	has_many :excavation_site_kinds
	def self.is_independent_of_paths
		true
	end
end
