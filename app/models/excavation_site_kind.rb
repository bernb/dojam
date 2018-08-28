class ExcavationSiteKind < Termlist
	belongs_to :excavation_site_category

	def self.is_independent_of_paths
		true
	end
end
