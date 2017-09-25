class MuseumObject < ApplicationRecord
  belongs_to :ex_site, required: false # do not require for now while in early dev state
  belongs_to :storage_location, required: false
end
