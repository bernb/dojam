class ExcavationSite < ApplicationRecord
  belongs_to :termlist_excavation_site_kind, required: false, foreign_key: 'excavation_site_kind_id' # for now in dev state without validations
  has_many :museum_objects, inverse_of: :excavation_site
end
