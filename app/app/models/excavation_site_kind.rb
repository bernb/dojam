class ExcavationSiteKind < Termlist
	has_many :excavation_site_category_kinds
	has_many :excavation_site_categories, through: :excavation_site_category_kinds
  has_many :museum_objects

	def self.is_independent_of_paths
		true
	end

end
