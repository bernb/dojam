class MuseumObject < ApplicationRecord
  include SearchCop

  mount_uploaders :images, ImageUploader
  belongs_to :excavation_site, -> { order(name: :asc) }, required: false # do not require for now while in early dev state
  belongs_to :storage_location
  belongs_to :termlist_acquisition_delivered_by, -> { order(name: :asc) }, required: false
  belongs_to :termlist_acquisition_kind, -> { order(name: :asc) }, required: false
  belongs_to :termlist_authenticity, required: false
  belongs_to :termlist_dating_millennium, required: false
  belongs_to :termlist_dating_period, required: false
  belongs_to :termlist_kind_of_object, required: false
  belongs_to :termlist_kind_of_object_specified, required: false
  belongs_to :termlist_production_technique, required: false
  belongs_to :termlist_decoration_technique, required: false
  belongs_to :termlist_decoration_color, required: false
  belongs_to :termlist_decoration, required: false
  belongs_to :termlist_preservation_material, required: false
  belongs_to :termlist_preservation_object, required: false
  belongs_to :termlist_inscription_letter, required: false
  belongs_to :termlist_inscription_language, required: false
  belongs_to :termlist_excavation_site_kind, required: false
  has_many :join_museum_object_material_specifieds
  has_many :termlist_material_specifieds, through: :join_museum_object_material_specifieds
  has_many :join_museum_object_colors
  has_many :termlist_colors, through: :join_museum_object_colors
  has_many :join_museum_object_dating_centuries
  has_many :termlist_dating_centuries, through: :join_museum_object_dating_centuries
  accepts_nested_attributes_for :excavation_site, reject_if: :all_blank, allow_destroy: true
  delegate :museum, to: :storage_location
  delegate :storage, to: :storage_location
  
  after_save :set_is_used
  
  
  search_scope :search do
    attributes :inv_number, :inv_numberdoa, :finding_context, :finding_remarks
    attributes :description_authenticities_name, :description_conservation, :description_preservation_state_name
    attributes :acquisition_deliverer_name
  end
  
  def set_is_used
    self.is_used = true
    MuseumObject.skip_callback(:save, :after, :set_is_used)
    self.save!
    MuseumObject.set_callback(:save, :after, :set_is_used)
  end
  
end
