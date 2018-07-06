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
	belongs_to :termlist_priority, required: false
	belongs_to :main_material_specified, class_name: "TermlistMaterialSpecified", foreign_key: "termlist_material_specified_id", required: false
  has_many :join_museum_object_material_specifieds
  has_many :termlist_material_specifieds, through: :join_museum_object_material_specifieds
	# This returns the single entry for the ms/koos (or ms/koo) combination
	has_many :material_specifieds_koo_specs, ->(me){
		if me.termlist_kind_of_object_specified.present? 
			where(material_specifieds_koo_specs: 
						{termlist_kind_of_object_specified: me.termlist_kind_of_object_specified}) 
		elsif me.termlist_kind_of_object.present? 
			joins(:termlist_kind_of_object_specified)
				.where(material_specifieds_koo_specs: 
								{termlist_kind_of_object_specifieds: 
				 {termlist_kind_of_object: me.termlist_kind_of_object}})
		end},
		through: :main_material_specified
	has_many :possible_production_techniques, through: :material_specifieds_koo_specs, source: :termlist_production_techniques
	has_many :termlist_production_techniques, through: :material_specifieds_koo_specs
  has_many :termlist_materials, -> { distinct }, through: :termlist_material_specifieds
  has_many :join_museum_object_colors, inverse_of: :museum_object
  has_many :termlist_colors, through: :join_museum_object_colors
  has_many :join_museum_object_dating_centuries
  has_many :termlist_dating_centuries, through: :join_museum_object_dating_centuries
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

	def acquisition_date
		return nil unless self.acquisition_year.present?
		date_parse_string = self.acquisition_year.to_s
		if self.acquisition_month.present?
			date_parse_string += "-" + self.acquisition_month.to_s
			if self.acquisition_day.present?
				date_parse_string += "-" + self.acquisition_day.to_s
				Date.parse(date_parse_string).strftime("%Y-%m-%d")
			else
				Date.parse(date_parse_string).strftime("%Y-%m")
			end
		else
			Date.parse(date_parse_string).strftime("%Y")
		end
	end


	def get_possible_props_for property_name
		Rails.logger.debug "Call PropsGetter with: "
		Rails.logger.debug "termlist_material_specified: " + (self.termlist_material_specifieds&.first&.name || "nil")
		Rails.logger.debug "termlist_kind_of_object_specified: " + (self.termlist_kind_of_object_specified&.name || "nil")
		Rails.logger.debug "termlist_kind_of_object: " + (self.termlist_kind_of_object&.name || "nil")
		Rails.logger.debug "property_name: " + (property_name&.to_s || "nil")
		PropsGetter.call termlist_material_specified: self.main_material_specified, termlist_kind_of_object_specified: self.termlist_kind_of_object_specified, termlist_kind_of_object: self.termlist_kind_of_object, property_name: property_name
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
