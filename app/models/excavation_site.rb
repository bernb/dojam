class ExcavationSite < ApplicationRecord
  has_many :museum_objects, inverse_of: :excavation_site

	def self.is_independent_of_paths
		true
	end
end
