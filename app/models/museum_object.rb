class MuseumObject < ApplicationRecord
  include SearchCop
  validates_with MuseumObjectValidator

  has_one :images, class_name: "MuseumObjectImageList", dependent: :destroy
  accepts_nested_attributes_for :images
  belongs_to :excavation_site, -> { order(name: :asc) }, required: false # do not require for now while in early dev state
  belongs_to :storage_location, required: false
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
  has_many :termlist_materials, -> { distinct }, through: :termlist_material_specifieds
  has_many :join_museum_object_colors
  has_many :termlist_colors, through: :join_museum_object_colors
  has_many :join_museum_object_dating_centuries
  has_many :termlist_dating_centuries, through: :join_museum_object_dating_centuries
  accepts_nested_attributes_for :excavation_site, reject_if: :all_blank, allow_destroy: true
  delegate :museum, to: :storage_location, allow_nil: true
  delegate :storage, to: :storage_location, allow_nil: true
  
  before_validation :set_is_used
  
  
  search_scope :search do
    attributes :inv_number, :inv_extension, :inv_numberdoa, :termlist_acquisition_delivered_by_id, :acquisition_deliverer_name, :acquisition_date,
                                          :finding_context, :finding_remarks, :termlist_authenticity_id, :priority, :priority_determined_by,
                                          :inscription_decoration, :inscription_text, :inscription_translation, 
                                          :excavation_site_id, :termlist_kind_of_object_id, :termlist_kind_of_object_specified_id,
                                          :acquisition_document_number, :name_expedition, :site_number_mega, :site_number_expedition,
                                          :coordinates_mega, :termlist_excavation_site_kind_id, :termlist_dating_period_id, :termlist_dating_millennium_id,
                                          :termlist_production_technique_id, :termlist_decoration_id, :termlist_decoration_color_id,
                                          :termlist_inscription_letter_id, :termlist_inscription_language_id,
                                          :remaining_length, :remaining_width, :remaining_height, :remaining_opening_dm, :remaining_bottom_dm, :remaining_weight_in_gram,
                                          :termlist_preservation_material_id, :termlist_preservation_object_id, :description_conservation,
                                          :remarks, :literature, :dating_timespan_begin, :dating_timespan_end
    attributes storage_location: "storage_location.name"
                                          
  end

  # is_used activates validations, supposed to get set after first save
  # as wickeg gem needs a valid/created entry to work
  # note that is_set will also reroll if validation fails  
  def set_is_used
    self.is_used = true unless self.new_record?
  end
  
  # Returns associated material specifieds only for given material
  def termlist_material_specifieds_for material
     TermlistMaterialSpecified.where(termlist_material: material).joins(:museum_objects).where(museum_objects: {id: self.id})
  end
  
  def card
    MuseumCardDecorator.new(self)
  end
  
  def has_material? material
    self.termlist_materials.ids.include? material.id
  end
  
  
end
