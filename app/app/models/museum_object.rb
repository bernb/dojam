class MuseumObject < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:finding_context,
                            :finding_remarks,
                            :description_conservation,
                            :acquisition_deliverer_name,
                            :inscription_decoration,
                            :inscription_text,
                            :inscription_translation,
                            :priority_determined_by,
                            :remarks,
                            :literature,
                            :acquisition_document_number,
                            :name_mega_jordan,
                            :name_expedition,
                            :site_number_mega,
                            :site_number_jadis,
                            :site_number_expedition,
                            :coordinates_mega_long,
                            :coordinates_mega_lat,
                            :munsell_color,
                            :description,
                            :remarks_acquisition]
  validates_with MuseumObjectValidator, on: :update
	before_create :set_default_values

  has_one :images, class_name: "MuseumObjectImageList", dependent: :destroy
  has_one :loan_out
	# ToDo: Remove redundant associations
	# ToDo: For path dependent terms use a single join table to allow easy querying of all associated terms.
  belongs_to :excavation_site, required: false 
  belongs_to :storage_location, required: false
  belongs_to :acquisition_delivered_by, required: false
  belongs_to :acquisition_kind, required: false
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
	alias_attribute :decoration_id, :decoration_style_id
  belongs_to :preservation_material, required: false
  belongs_to :preservation_object, required: false
  belongs_to :inscription_letter, required: false
  belongs_to :inscription_language, required: false
  belongs_to :excavation_site_kind, required: false
  belongs_to :excavation_site_category, required: false
	belongs_to :priority, required: false
	belongs_to :main_path, class_name: "Path", required: false
	has_many :museum_object_paths
	has_many :secondary_paths, class_name: "Path",  through: :museum_object_paths, source: :path do
		def <<(values)
			values = proxy_association.owner.exclude_parent_and_same(values)
			super values.map{|p| p.to_depth(2)}
		end
	end
	has_many :color_museum_objects
	has_many :colors, through: :color_museum_objects
  has_many :production_technique_museum_objects
  has_many :production_techniques, through: :production_technique_museum_objects 
  has_many :decoration_style_museum_objects
  has_many :decoration_styles, through: :decoration_style_museum_objects
  has_many :decoration_technique_museum_objects
  has_many :decoration_techniques, through: :decoration_technique_museum_objects
  has_many :decoration_color_museum_objects
  has_many :decoration_colors, through: :decoration_color_museum_objects
  has_many :inscription_letter_museum_objects
  has_many :inscription_letters, through: :inscription_letter_museum_objects
  has_many :inscription_language_museum_objects
  has_many :inscription_languages, through: :inscription_language_museum_objects
  delegate :museum, to: :storage_location, allow_nil: true
  delegate :storage, to: :storage_location, allow_nil: true
  accepts_nested_attributes_for :images, :secondary_paths
	scope :where_path, ->(given_path) {
		left_outer_joins(:secondary_paths)
			.where(main_path: given_path)
			.or(
				where(paths: {id: given_path})) }
	scope :museum, ->(given_museum) {
		joins(storage_location: {storage: :museum})
			.where('museum.id': given_museum)
	}
  
  before_validation :set_is_used
  
	def get_possible_props_for classname
		if classname.constantize.is_independent_of_paths
			return classname.constantize.all
		else
			if self.main_path.blank?
				return classname.constantize.where(name_en: "undetermined")
			end
			return self.main_path.termlists.where(type: classname)
		end
	end

	########################
	# m/ms/koo/koos getter #
	########################
	
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

	def secondary_materials
		secondary_paths&.map(&:objects)&.[](0)
	end

	def secondary_material_specifieds
		secondary_paths&.map(&:objects)&.[](1)
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

	def material_specifieds
		paths_objects_for 2
	end

	def material_specified_ids
		ids = []
		material_specifieds.each do |material_specified|
			ids << material_specified.id
		end
		return ids
	end

	########################
	##### path methods #####
	########################

	# ToDo: Implement as scope
	def paths
		paths = Path.none
		if main_path.present?
			paths = Path.where id: main_path.id
		end
		if secondary_paths.present?
			paths = paths.or(Path.where id: secondary_path_ids)
		end
		return paths
	end

	# ToDo: It might be way easier and more intuitive to no override this method but instead let the controller get the
	# correct paths to present to the user
	# One thing this method does is rewrite the path so that if '/metal' is given what is actually saved is the path matching
	# '/metal/undetermined/undetermined/undetermined'
	def secondary_paths=(new_paths)
		# Allow for single path and array of paths
		new_paths = [new_paths].flatten

    # Remove undetermined path if any other path is set
#    if self.main_path == Path.undetermined_path &&
#        new_paths.any?
#      self.main_path = nil
#    end

		# If new paths are not consistent with choosen main path, remove it
		if main_path.present? && !main_path.included_or_child_of?(new_paths)
      self.main_path = nil
		else
			# Else remove paths, that are already implied in main path
			# but not implied by any secondary paths
			new_paths = new_paths.reject{|p| 
				p.included_or_parent_of?(self.main_path) && 
					!path_in_secondary_implied?(p)}
		end

		# We remove paths that are already implied in secondary paths
		# For that, we replace every path with any more specific paths and
		# call uniq in the end
		new_paths = new_paths
			.map{|p| path_in_secondary_implied?(p) ? implied_secondary_paths_for(p) : p}
			.flatten
			.uniq

		# Always map to maximum depth of 2
		new_paths = new_paths.map{|p| p.to_depth(2)}

    # Also do not save depth 1, but replace with
    # undetermined child of depth 2
    new_paths = new_paths.map{|p| p.depth == 1 ? p.undetermined_child : p}
		
		super new_paths
	end

#def secondary_paths=(new_paths)
#	# Keep paths that are more specific than given ones
#	self.secondary_paths.delete_all
#	self.secondary_paths << new_paths
#end


	def secondary_path_ids=(ids)
		ids = ids.reject(&:empty?)
		paths = Path.find(ids)
		self.secondary_paths = paths
	end

	def main_path=(path)
		if path.blank?
			super path
			return
		end
		# Ignore if more specific path already set
		if path.parent_of? main_path
			return
		end
		# Remove from secondary paths if found
		if secondary_paths.include?(path)
			secondary_paths.delete(path)
		else
			# Also remove if a parent was set as secondary path.
			# So we remove /1/2/3 if /1/2/3/4 is the main path now
		 	parent = secondary_paths.find{|p| p.parent_of?(path)}
			if parent.present?
				secondary_paths.delete(parent)
			end
		end
		# Move old main path to secondary paths
		if main_path.present?
			new_secondary_path = main_path.to_depth(2)
			super path
			secondary_paths << new_secondary_path
		end
		super path
	end

	def main_path_id=(id)
		path = Path.find(id)
		self.main_path = path
	end

	# For simplicify, we keep a kind of object specified
	# setter for now
	def kind_of_object_specified=(koos)
		new_path = self.main_path
			.to_depth(3)
			.direct_children
			.find{|p| p.objects.last == koos}
		self.main_path = new_path unless new_path.blank?
	end

	def kind_of_object_specified_id=(koos_id)
		koos = KindOfObjectSpecified.find koos_id
		self.kind_of_object_specified = koos
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

	# Used in material specified view for now
	def smart_paths
		self.paths.or(self.main_path)
	end

	def smart_path_ids
		ids = self.path_ids
		ids << self.main_path_id
		return ids
	end

	def smart_path_ids=(ids)
		paths = Path.find ids.reject(&:blank?)
		self.smart_paths = paths
	end

	def smart_paths=(paths)
		add_new_paths paths
	end

	def exclude_parent_and_same(paths)
		is_parent = false
		new_paths = []
		# Little trick to allow for single path and also multiple paths as array
		[paths].flatten.each do |path|
			if path.parent_of?(main_path) || path == main_path
				is_parent = true
			end
			secondary_paths.each do |secondary_path|
				if path.parent_of?(secondary_path) || path == secondary_path
					is_parent = true
				end
			end
			if is_parent
				next
			else
				new_paths << path
			end
		end
		return new_paths
	end

  def on_loan?
    # Get the latest loan in terms of loan start date and
    # check if it was returned already
    loan = LoanOut.where(museum_object: self).order(:date_out).first
    return loan.present? && loan.return_date.blank?
  end

	private

	def add_new_paths paths
		new_paths = []
		paths.each do |path|
			if path.parent_of?(self.main_path) || path == self.main_path
				next
			end
			if path_implied?(path)
				new_paths << implied_paths_for(path)
			else
				new_paths << path
			end
		end
		if new_paths.empty?
			self.paths.delete_all
		else
			self.paths = new_paths.flatten
		end
	end

	def implied_paths_for path
		self.paths.select{|p| p.child_of?(path)}
	end

	def path_implied? path
		self.paths.map{|p| p.child_of?(path)}.reduce(:|)
	end

	def implied_secondary_paths_for path
		self.secondary_paths.select{|p| p.included_or_child_of?(path)}
	end

	def path_in_secondary_implied? path
		self.secondary_paths.map{|p| p.included_or_child_of?(path)}.reduce(:|)
	end

	# ToDo: This is not the best/proper way to do it Better way might be to use a after_initialize callback
	def set_default_values
		self.main_path 									||= Path.undetermined_path
		self.excavation_site 						||= ExcavationSite.undetermined
		self.acquisition_kind 					||= AcquisitionKind.undetermined
		self.acquisition_delivered_by 	||= AcquisitionDeliveredBy.undetermined
		self.excavation_site_kind 			||= ExcavationSiteKind.undetermined
		self.excavation_site_category 	||= ExcavationSiteCategory.undetermined
		self.production_technique 			||= ProductionTechnique.undetermined
		self.decoration_technique 			||= DecorationTechnique.undetermined
		self.decoration_color 					||= DecorationColor.undetermined
		self.decoration_style 					||= Decoration.undetermined # Table got renamed to 'decorations' at some point
		self.inscription_letter 				||= InscriptionLetter.undetermined
		self.inscription_language 			||= InscriptionLanguage.undetermined
		self.preservation_material 			||= PreservationMaterial.undetermined
		self.preservation_object 				||= PreservationObject.undetermined
		self.authenticity 							||= Authenticity.undetermined
		self.priority 									||= Priority.undetermined
		self.dating_period 							||= DatingPeriod.undetermined
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

  def self.search param, user
    # Multisearch gives a mix of terms and museum objects
    # we map those to museum objects ids and on the result
    # so that we we a active records relation of museum objects as result
    # which can be processed in a clean way, for example for pagination
    search_result = PgSearch.multisearch param
    museum_object_ids = search_result
      .map{|r| r.searchable_type.constantize.find r.searchable_id}
      .map{|r| r.class < Termlist ? r.museum_objects : r}
      .flatten
      .map(&:id)
      .sort
    return Pundit::policy_scope(user, MuseumObject).where(id: museum_object_ids)&.order(:id)
  end

end
