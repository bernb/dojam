class ExcavationSite < ApplicationRecord
  has_many :museum_objects, inverse_of: :excavation_site, dependent: :restrict_with_error
  default_scope {order(Arel.sql("excavation_sites.name = 'undetermined'"), name: :asc)}

	def self.is_independent_of_paths
		true
	end

  def self.undetermined
    return ExcavationSite.find_by name: "undetermined"
  end
end
