class MuseumObject < ApplicationRecord
  include SearchCop
  validates_with MuseumObjectValidator
	after_initialize :set_default_values

  has_one :images, class_name: "MuseumObjectImageList", dependent: :destroy
  accepts_nested_attributes_for :images
  belongs_to :excavation_site, -> { order(name: :asc) }, required: false # do not require for now while in early dev state
  belongs_to :storage_location, required: false
  belongs_to :acquisition_delivered_by, -> { order(name: :asc) }, required: false
  belongs_to :acquisition_kind, -> { order(name: :asc) }, required: false
  belongs_to :authenticity, required: false
  belongs_to :dating_millennium_begin, required: false, class_name: "DatingMillennium"
  belongs_to :dating_millennium_end, required: false, class_name: "DatingMillennium"
  belongs_to :dating_century_begin, required: false, class_name: "DatingCentury"
  belongs_to :dating_century_end, required: false, class_name: "DatingCentury"
  belongs_to :dating_period, required: false
  belongs_to :production_technique, required: false
  belongs_to :decoration_technique, required: false
  belongs_to :decoration_color, required: false
  belongs_to :decoration, required: false, foreign_key: 'decoration_style_id'
  belongs_to :preservation_material, required: false
  belongs_to :preservation_object, required: false
  belongs_to :inscription_letter, required: false
  belongs_to :inscription_language, required: false
  belongs_to :excavation_site_kind, required: false
  belongs_to :excavation_site_category, required: false
	belongs_to :priority, required: false
	has_many :museum_object_paths
	has_many :paths, through: :museum_object_paths
	has_many :color_museum_objects
	has_many :colors, through: :color_museum_objects
	belongs_to :main_path, class_name: "Path", required: false
  delegate :museum, to: :storage_location, allow_nil: true
  delegate :storage, to: :storage_location, allow_nil: true
  
  before_validation :set_is_used
  
  
  search_scope :search do
    attributes :inv_number, 
               :inv_extension, 
               :inv_numberdoa, 
               :acquisition_deliverer_name, 
               :finding_context, 
               :finding_remarks, 
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

	# We do not use path scopes as this way we avoid boiler plate code for every single property/scope
	def get_possible_props_for classname
		if !(classname.constantize < Termlist) && classname != "ExcavationSite"
			return nil
		end
		if classname.constantize.is_independent_of_paths
			# We cast to array to achieve consistency, see below for more information
			termlist_ids = classname.constantize.where.not(name: "undetermined").ids
		else
			termlist_ids = self.main_path.termlists.where(type: classname).where.not(name: "undetermined").ids
		end
		if self.main_path.blank?
			return nil
		end
		# We merge by hand here so we do not neccessarily need to add the undetermined entries to every single possible path
		# We use the plus operation on the result sets to achieve the correct sorting
		undetermined_entry_id = Termlist.where(type: classname).where(name: "undetermined").ids
		Termlist.find(termlist_ids) + Termlist.find(undetermined_entry_id)
	end

	def kind_of_object_specified
		self.main_path&.objects&.[](3)
	end

	def kind_of_object_specified_id
		self.kind_of_object_specified&.id
	end

	def kind_of_object_specified=(kind_of_object_specified)
		path_name = self.kind_of_object.paths.first.path + "/" + kind_of_object_specified&.id&.to_s
		path = Path.find_by path: path_name
		self.main_path = path
		self.save
	end

	def kind_of_object_specified_id=(kind_of_object_specified_id)
		kind_of_object_specified = KindOfObjectSpecified.find kind_of_object_specified_id
		self.kind_of_object_specified = kind_of_object_specified
	end

	def kind_of_object
		self.main_path&.objects&.[](2)
	end

	def kind_of_object_id
		self.kind_of_object&.id
	end

	def kind_of_object=(kind_of_object)
		path_name = self.main_material_specified.paths.first.path + "/" + kind_of_object&.id&.to_s
		path = Path.find_by path: path_name
		self.main_path = path
		self.save
	end

	def kind_of_object_id=(kind_of_object_id)
		kind_of_object = KindOfObject.find kind_of_object_id
		self.kind_of_object = kind_of_object
	end

	def main_material
		# Note there is the safe navigation version of objects[2]
		self.main_path&.objects&.[](0)
	end

	def main_material_specified
		# Note there is the safe navigation version of objects[2]
		self.main_path&.objects&.[](1)
	end

	def set_main_material_specified=(main_material_specified)
		path = Path.find_in_depth_two(main_material_specified.id).first
		# Workaround for the fact that ms and koo get saved parallel i.e. overwriting each other
		self.main_path = path 
	end

	# Dirty workaround to get correct values for edit form
	# and also never actually save, but set it before in ajax call in custom method
	def main_material_specified=(main_material_specified)
	end

	def main_material_specified_id
		main_material_specified&.id
	end

	def main_material_specified_id=(main_material_specified_id)
		# Don't do anything right now as at the moment we save material_specified always together with kind_of_object
		# As they both set main_path, they overwrite each other if set in parallel
		#main_material_specified = MaterialSpecified.find main_material_specified_id
		#self.main_material_specified = main_material_specified
	end

	def materials
		paths_objects_for 1
	end

	def material_ids
		ids = []
		materials.each do |material|
			ids << material.id
		end
		return ids
	end

	def material_ids=(material_object_ids)
		material_object_ids = material_object_ids.reject{|m| m.blank?}
		material_objects = Material.find material_object_ids
		self.materials = material_objects
	end

	def materials=(material_objects)
		paths = []
		material_objects.each do |object|
			path = Path.find_in_depth_one object.id
			paths << path
		end
		self.paths.clear
		self.paths << paths
	end

	def material_specifieds
		paths_objects_for 2
	end

	def material_specifieds=(material_specified_objects)
		paths = []
		material_specified_objects.each do |object|
			path = Path.find_in_depth_two object.id
			paths << path
		end
		self.paths.clear
		self.paths << paths
	end

	def material_specified_ids
		ids = []
		material_specifieds.each do |material_specified|
			ids << material_specified.id
		end
		return ids
	end

	def material_specified_ids=(material_specified_object_ids)
		material_specified_object_ids = material_specified_object_ids.reject{|m| m.blank?}
		material_specified_objects = MaterialSpecified.find material_specified_object_ids
		self.material_specifieds = material_specified_objects
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

	def set_default_values
		termlist_names = [:excavation_site,
										  :acquisition_kind,
											:acquisition_delivered_by,
											:excavation_site_kind,
											:excavation_site_category,
											:production_technique,
											:decoration_technique,
											:decoration_color,
											:decoration,
											:inscription_letter,
											:inscription_language,
											:preservation_material,
											:preservation_object,
											:authenticity,
											:priority,
											:dating_period,
		]
		termlist_names.each do |termlist_name|
			undetermined_entry = termlist_name.to_s.camelize.constantize.find_by(name: "undetermined")
			self.send(termlist_name.to_s+"=", undetermined_entry) if self.send(termlist_name.to_s).blank?
		end
	end

	def paths_objects_for depth
		objects = []
		objects << self.main_path.objects[depth-1] unless self.main_path.blank?
		self.paths.each do |path|
			# Lowest depth is 1, but first array element at 0
			objects << path.objects[depth-1] unless path.objects[depth-1].blank?
		end
		return objects.uniq
	end
  
  
end
