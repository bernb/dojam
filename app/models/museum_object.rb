class MuseumObject < ApplicationRecord
  belongs_to :excavation_site, required: false # do not require for now while in early dev state
  belongs_to :storage_location, required: false
  belongs_to :termlist_acquisition_delivered_by, required: false
  belongs_to :termlist_acquisition_kind, required: false
  accepts_nested_attributes_for :excavation_site, reject_if: :all_blank, allow_destroy: true
end
