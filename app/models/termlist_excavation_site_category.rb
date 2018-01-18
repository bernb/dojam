class TermlistExcavationSiteCategory < ApplicationRecord
  has_many :termlist_excavation_site_kinds, -> { order(name: :asc) }
end
