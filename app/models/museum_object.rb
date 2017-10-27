class MuseumObject < ApplicationRecord
  include SearchCop

  belongs_to :excavation_site, required: false # do not require for now while in early dev state
  belongs_to :storage_location, required: false
  belongs_to :termlist_acquisition_delivered_by, required: false
  belongs_to :termlist_acquisition_kind, required: false
  belongs_to :termlist_authenticity, required: false
  belongs_to :termlist_dating_millennium, required: false
  belongs_to :termlist_kind_of_object, required: false
  belongs_to :termlist_kind_of_object_specified, required: false
  belongs_to :termlist_production, required: false
  belongs_to :termlist_decoration, required: false
  has_many :join_museum_object_material_specifieds
  has_many :termlist_material_specifieds, through: :join_museum_object_material_specifieds
  has_many :join_museum_object_colors
  has_many :termlist_colors, through: :join_museum_object_colors
  accepts_nested_attributes_for :excavation_site, reject_if: :all_blank, allow_destroy: true
  delegate :museum, to: :storage_location
  delegate :storage, to: :storage_location
  
  
  search_scope :search do
    attributes :inv_number, :inv_numberdoa, :finding_context, :finding_remarks
    attributes :description_authenticities_name, :description_conservation, :description_preservation_state_name
    attributes :acquisition_deliverer_name
    attributes :inscription_decoration, :inscription_letters, :inscription_language, :inscription_text, :inscription_translation
    attributes excavation_site: ["excavation_site.name", "excavation_site.name_mega_jordan", "excavation_site.name_expedition"]
    attributes excavation_site: ["excavation_site.site_number_mega", "excavation_site.site_number_jadis", "excavation_site.site_number_expedition"]
  end
  
end
