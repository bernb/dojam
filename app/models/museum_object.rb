class MuseumObject < ApplicationRecord
  include SearchCop
  validates_with MuseumObjectValidator

  has_one :images, class_name: "MuseumObjectImageList", dependent: :destroy
  accepts_nested_attributes_for :images
  belongs_to :excavation_site, -> { order(name: :asc) }, required: false # do not require for now while in early dev state
  belongs_to :storage_location, required: false
  belongs_to :termlist_acquisition_delivered_by, -> { ormer(name: :asc) }, required: false
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
	has_many :material_specifieds_koo_specs, -> (me) {
		if me.termlist_kind_of_object_specified.present?
			puts "TRIGGERED *****"
			joins(:termlist_kind_of_object_specifieds)
				where(termlist_kind_of_object_specified: me.termlist_kind_of_object_specified)
		elsif me.termlist_kind_of_object.present?
			self.joins(termlist_kind_of_object_specified: :termlist_kind_of_object).where(termlist_kind_of_objects: {id: me.termlist_kind_of_object.id})
		end
	}, through: :termlist_material_specifieds
  has_many :termlist_materials, -> { distinct }, through: :termlist_material_specifieds
  has_many :join_museum_object_colors, inverse_of: :museum_object
  has_many :termlist_colors, through: :join_museum_object_colors
  has_many :join_museum_object_dating_centuries
  has_many :termlist_dating_centuries, through: :join_museum_object_dating_centuries
	has_many :prod_techs_ms_koo_specs, through: :material_specifieds_koo_specs
	has_many :possible_production_techniques, through: :prod_techs_ms_koo_specs, source: :termlist_production_technique
  accepts_nested_attributes_for :excavation_site, reject_if: :all_blank, allow_destroy: true
  delegate :museum, to: :storage_location, allow_nil: true
  delegate :storage, to: :storage_location, allow_nil: true
  
  before_validation :set_is_used
  
  
  search_scope :search do
    attributes :inv_number, 
               :inv_extension, 
               :inv_numberdoa, 
               :acquisition_deliverer_name, 
               :acquisition_date,
               :finding_context, 
               :finding_remarks, 
               :priority, 
               :priority_determined_by,
               :inscription_decoration, 
               :inscription_text, 
               :inscription_translation, 
               :acquisition_document_number, 
               :name_expedition, 
               :site_number_mega, 
               :site_number_expedition,
               :description_conservation,
               :remarks, 
               :literature
    attributes storage_location: "storage_location.name"
    attributes termlist_preservation_material: "termlist_preservation_material.name"
    attributes termlist_excavation_site_kind: "termlist_excavation_site_kind.name"
    attributes termlist_authenticity: "termlist_authenticity.name"
    attributes termlist_preservation_object: "termlist_preservation_object.name"
    attributes termlist_inscription_language: "termlist_inscription_language.name"
    attributes termlist_kind_of_object: "termlist_kind_of_object.name"
    attributes termlist_kind_of_object_specified: "termlist_kind_of_object_specified.name"
    attributes termlist_decoration: "termlist_decoration.name"
    attributes termlist_acquisition_delivered_by: "termlist_acquisition_delivered_by.name"
    attributes termlist_dating_millennium: "termlist_dating_millennium.name"
    attributes termlist_production_technique: "termlist_production_technique.name"
    attributes termlist_decoration_color: "termlist_decoration_color.name"
    attributes termlist_inscription_letter: "termlist_inscription_letter.name"
    attributes termlist_inscription_language: "termlist_inscription_language.name"
    attributes excavation_site: "excavation_site.name"
    attributes termlist_material: "termlist_materials.name"
    
                                          
  end

	def props
		if self.termlist_kind_of_object_specified.present?
			temp_props = self.termlist_kind_of_object_specified.props
		else
			temp_props = self.termlist_kind_of_object.props
		end
		return temp_props.where(termlist_material_specified: self.termlist_material_specifieds)
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
