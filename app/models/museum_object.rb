class MuseumObject < ApplicationRecord
  include SearchCop
  validates_with MuseumObjectValidator

  has_one :images, class_name: "MuseumObjectImageList", dependent: :destroy
  accepts_nested_attributes_for :images
  belongs_to :excavation_site, -> { order(name: :asc) }, required: false # do not require for now while in early dev state
  belongs_to :storage_location, required: false
  belongs_to :acquisition_delivered_by, -> { order(name: :asc) }, required: false
  belongs_to :acquisition_kind, -> { order(name: :asc) }, required: false
  belongs_to :authenticity, required: false
  belongs_to :dating_millennium, required: false
  belongs_to :dating_period, required: false
  belongs_to :kind_of_object, required: false
  belongs_to :kind_of_object_specified, required: false
  belongs_to :production_technique, required: false
  belongs_to :decoration_technique, required: false
  belongs_to :decoration_color, required: false
  belongs_to :decoration, required: false
  belongs_to :preservation_material, required: false
  belongs_to :preservation_object, required: false
  belongs_to :inscription_letter, required: false
  belongs_to :inscription_language, required: false
  belongs_to :excavation_site_kind, required: false
	belongs_to :priority, required: false
#	has_many :material_museum_objects
#	has_many :material_specified_museum_objects
#	has_many :materials, through: :material_museum_objects
#	has_many :material_specifieds, through: :material_specified_museum_objects
#	belongs_to :main_material_specified, class_name: "MaterialSpecified", foreign_key: "material_specified_id", required: false
	has_many :museum_object_paths
	has_many :paths, through: :museum_object_paths
	belongs_to :main_path, class_name: "Path", required: false
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
    
                                          
  end

	def materials
		self.paths_objects_for 1
	end

	def materials=(material_object_ids)
		paths = []
		material_objects = Material.find material_object_ids
		material_objects.each do |object|
			path = Path.find_in_depth_one object.id
			paths << path
		end
		self.paths = paths
	end

	def material_specifieds
		self.paths_objects_for 2
	end

	def material_specifieds=(material_specified_object_ids)
		paths = []
		material_specified_objects = MaterialSpecified.find material_specified_object_ids
		material_specified_objects.each do |object|
			path = Path.find_in_depth_two object.id
			paths << path
		end
		self.paths = paths
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
				date_parse_string += "-01"
				Date.parse(date_parse_string).strftime("%b %Y")
			end
		else
			date_parse_string += "-01-01"
			Date.parse(date_parse_string).strftime("%Y")
		end
	end

	def acquisition_date_unknown
		return self.acquisition_year.blank? && self.acquisition_month.blank? && acquisition_day.blank?
	end

	def acquisition_date_unknown=(val)
		if val == "1" || val == true
			self.acquisition_year = nil
			self.acquisition_month = nil
			self.acquisition_day = nil
		end
	end

  # is_used activates validations, supposed to get set after first save
  # as wickeg gem needs a valid/created entry to work
  # note that is_set will also reroll if validation fails  
  def set_is_used
    self.is_used = true unless self.new_record?
  end
  
  def card
    MuseumCardDecorator.new(self)
  end
  
  def has_material? material
    self.materials.ids.include? material.id
  end

	private

	def paths_objects_for depth
		objects = []
		self.paths.each do |path|
			objects << path.objects[depth] unless path.objects[depth].blank?
		end
		return objects
	end
  
  
end
