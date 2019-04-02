class ExcavationSiteCategoryKind < ApplicationRecord
  belongs_to :excavation_site_category, class_name: "Termlist"
  belongs_to :excavation_site_kind, class_name: "Termlist"
end
