class MuseumObject < ApplicationRecord
  include SearchCop
  validates_with MuseumObjectValidator
	after_initialize :set_default_values

  has_one :images, class_name: "MuseumObjectImageList", dependent: :destroy
  accepts_nested_attributes_for :images
  belongs_to :excavation_site, -> { order(name: :asc) }, required: false 
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
  belongs_to :decoration_style, required: false, class_name: "Decoration"
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

	def get_possible_props_for classname
		if classname.constantize.is_independent_of_paths
			return classname.constantize.all
		else
			if self.main_path.blank?
				return classname.constantize.none
			end
			return self.main_path.termlists.where(type: classname)
		end
	end

	########################
	# m/ms/koo/koos getter #
	# ######################
	def main_material
		# Note there is the safe navigation version of objects[2]
		self.main_path&.objects&.[](0)
	end

	def main_material_id
		main_material_specified&.id
	end

	def main_material_specified
		# Note there is the safe navigation version of objects[2]
		self.main_path&.objects&.[](1)
	end

	def main_material_specified_id
		main_material_specified&.id
	end

	def kind_of_object
		self.main_path&.objects&.[](2)
	end

	def kind_of_object_id
		self.kind_of_object&.id
	end

	def kind_of_object_specified
		self.main_path&.objects&.[](3)
	end

	def kind_of_object_specified_id
		self.kind_of_object_specified&.id
	end

	########################
	# m/ms/koo/koos setter #
	########################
	
	def main_material_id= m_id
		path = Path.depth(1).last_id(m_id).first
		self.main_path = path
	end
	
	def main_material= material
		self.main_material_id = material.id
	end

	def main_material_specified_id= ms_id
		m_id = self.main_path.objects[0].id.to_s
		path = Path.find_by path: "/#{m_id}/#{ms_id.to_s}"
		self.main_path = path
	end

	def main_material_specified= material_specified
		self.main_materal_specified_id = material_specified.id
	end

	def kind_of_object_id= koo_id
		objects = self.main_path.objects
		m_id = objects[0].id.to_s
		ms_id = objects[1].id.to_s
		path = Path.find_by path: "/#{m_id}/#{ms_id}/#{koo_id.to_s}"
		self.main_path = path
	end

	def kind_of_object= kind_of_object
		self.kind_of_object_id = kind_of_object.id
	end

	def kind_of_object_specified_id= koos_id
		objects = self.main_path.objects
		m_id = objects[0].id.to_s
		ms_id = objects[1].id.to_s
		koo_id = objects[2].id.to_s
		path = Path.find_by path: "/#{m_id}/#{ms_id}/#{koo_id}/#{koos_id.to_s}"
		self.main_path = path
	end

	def kind_of_object_specified= kind_of_object_specified
		self.kind_of_object_specified_id = kind_of_object_specified.id
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

	def materials=(material_objects)
		material_paths = material_objects
			.map(&:paths)
			.map(&:first)
			.map(&:path)
		paths = Path.where('path like any (array[?])', material_paths)
		add_new_paths paths
	end

	def material_ids=(material_object_ids)
		material_object_ids = material_object_ids.reject{|m| m.blank?}
		material_objects = Material.find material_object_ids
		self.materials = material_objects
	end

	def material_specifieds
		paths_objects_for 2
	end

	def material_specifieds=(material_specified_objects)
		paths = []
		# Note that we assume a one-to-many relationship
		material_specified_objects.each do |object|
			path = Path.depth(2).last_id(object.id)
			paths << path
		end
		add_new_paths paths
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

	def add_new_paths paths
		self.paths = paths.reject{|p| path_implied?(p)}
	end

	def path_implied? path
		self.paths.map{|p| p.parent_of?(path)}.reduce(:|)
	end

	def set_default_values
		termlist_names = [:excavation_site,
										  :acquisition_kind,
											:acquisition_delivered_by,
											:excavation_site_kind,
											:excavation_site_category,
											:production_technique,
											:decoration_technique,
											:decoration_color,
											:decoration_style,
											:inscription_letter,
											:inscription_language,
											:preservation_material,
											:preservation_object,
											:authenticity,
											:priority,
											:dating_period,
		]
		termlist_names.each do |termlist_name|
			if termlist_name == :decoration_style
				undetermined_entry = Decoration.find_by(name: "undetermined")
				self.send(termlist_name.to_s+"=", undetermined_entry) if self.send(termlist_name.to_s).blank?
			else
				undetermined_entry = termlist_name.to_s.camelize.constantize.find_by(name: "undetermined")
				self.send(termlist_name.to_s+"=", undetermined_entry) if self.send(termlist_name.to_s).blank?
			end
		end
	end

	# depth 1 = materials
	# depth 2 = material specifieds
	# merges objects of main_path with other (secendory) paths / materials
	def paths_objects_for depth
		objects = []
		objects << self.main_path.objects[depth-1] unless self.main_path.blank?
		self.paths.each do |path|
			# Lowest depth is 1, but first array element at 0
			objects << path.objects[depth-1] unless path.objects[depth-1].blank?
		end
		return objects.uniq
	end

#	def main_path=(material: nil, material_specified: nil, kind_of_object: nil, kind_of_object_specified: nil)
#		# ToDo: Throw error instead of returning nil
#		# Map given parameter to an logical integer array with
#		# 1: parameter was given
#		# 0: parameter is blank
#		parameter_array = [material, material_specified, kind_of_object, kind_of_object_specified] 
#		logical_array = parameter_array.map(&:present?).map{|l| l ? 1 : 0}
#		parameters_are_consistent = logical_array.each_cons(2).all?{|left, right| left >= right}
#		if !parameters_are_consistent
#			return nil
#		end
#
#		path = parameter_array.reject(&:blank?).reduce(""){|path, object| path += "/" + object.id}
#
#	end

end
