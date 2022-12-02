class ExcavationSiteCategory < Termlist
  has_many :museum_objects, dependent: :restrict_with_error
	has_many :excavation_site_category_kinds
	has_many :excavation_site_kinds, through: :excavation_site_category_kinds, dependent: :restrict_with_error
	def self.is_independent_of_paths
		true
	end

	def self.undetermined
		site_kind_undetermined = ExcavationSiteKind.undetermined
		site_category_undetermined = ExcavationSiteCategory.find_or_create_by name_en: 'undetermined'
		site_category_undetermined.excavation_site_kinds << site_kind_undetermined
		return site_category_undetermined
	end
end
