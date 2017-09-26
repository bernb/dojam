class MuseumObject < ApplicationRecord
  belongs_to :ex_site, required: false # do not require for now while in early dev state
  belongs_to :storage_location, required: false
  belongs_to :termlist_acquisition_delivered_by, required: false
  belongs_to :termlist_acquisition_kind, required: false
end
