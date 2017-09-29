class MuseumObject < ApplicationRecord
  belongs_to :excavation_site, required: false # do not require for now while in early dev state
  belongs_to :storage_location, required: false
  belongs_to :termlist_acquisition_delivered_by, required: false
  belongs_to :termlist_acquisition_kind, required: false
  belongs_to :termlist_authenticity, required: false
  has_many :join_museum_object_material_specifieds
  has_many :termlist_material_specifieds, through: :join_museum_object_material_specifieds
  has_many :join_museum_object_colors
  has_many :termlist_colors, through: :join_museum_object_colors
  accepts_nested_attributes_for :excavation_site, reject_if: :all_blank, allow_destroy: true
  delegate :museum, to: :storage_location
  delegate :storage, to: :storage_location
end
