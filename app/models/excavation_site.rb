class ExcavationSite < ApplicationRecord
  belongs_to :excavation_site_kind, required: false # for now in dev state without validations
  has_many :museum_objects
end
