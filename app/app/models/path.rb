class Path < ApplicationRecord
	has_many :termlist_paths
	has_many :termlists, through: :termlist_paths, dependent: :destroy
	has_many :museum_object_paths
	# ToDo: Refactor the names, because "museum_objects" for only secondary objects is very surprising
	has_many :museum_objects,
					 through: :museum_object_paths,
					 dependent: :restrict_with_error
  has_many :museum_objects_as_main,
					 class_name: "MuseumObject",
					 foreign_key: :main_path_id,
					 dependent: :restrict_with_error
	scope :last_id, ->(id) {where "path like ?", "%/#{id}"}
	scope :with_id, ->(id) {where "path like ?", "%#{id}%"}
	scope :depth, ->(depth) {where "path similar to ?", "/\\d{1,}" * depth}
	scope :default_order, -> {joins(:termlists)
		.order(Arel.sql("termlists.name_en = 'undetermined'"))
		.order(Arel.sql('termlists.name_en'))}
	scope :materials, ->{depth(1).default_order}
	scope :material_id, ->(id){where "path like ?", "%/#{id}%"}
	scope :material_specifieds, ->{depth(2).default_order}
	scope :kind_of_objects, ->{depth(3).default_order}
	scope :kind_of_object_specifieds, ->{depth(4).default_order}
	scope :self_with_transitive_children, ->(path){where("path LIKE ?", path.path + '%')}
	scope :transitive_children, ->(path){where("path LIKE ?", path.path + '/%')}
	scope :direct_children, ->(path){where("path SIMILAR TO ?", path.path + '/\\d{1,}')}
	before_destroy :destroy_transitive_children

	def all_museum_objects
		MuseumObject.where_path(self)
	end

	def all_transitive_museum_objects
		MuseumObject.where_path(self.transitive_children)
	end

	def all_transitive_with_self_museum_objects
		MuseumObject.where_path(self.self_with_transitive_children)
	end

	def self.undetermined_path
		m_id = Material.undetermined.id.to_s
		ms_id = MaterialSpecified.undetermined.id.to_s
		koo_id = KindOfObject.undetermined.id.to_s
		koos_id = KindOfObjectSpecified.undetermined.id.to_s

		return Path.find_or_create_by path: "/#{m_id}/#{ms_id}/#{koo_id}/#{koos_id}"
	end

  # Will not copy path that relates to own m/ms/koo/koos
  def copy_all_from(other)
    ar = ["Material", "MaterialSpecified", "KindOfObject", "KindOfObjectSpecified"] 
    termlists = other.termlists.reject{|t| t.type.in? ar}
    museum_objects_main = other.museum_objects_as_main
    museum_objects_sec = other.museum_objects
    self.termlists << termlists.reject{|t| t.in? self.termlists}
    self.museum_objects_as_main << museum_objects_main.reject{|m| m.in? self.museum_objects_as_main}
    self.museum_objects << museum_objects_sec.reject{|m| m.in? self.museum_objects}
  end

  def move_all_from(other)
    copy_all_from(other)
    other.termlists.delete_all
    other.museum_objects_as_main.delete_all
    other.museum_objects.delete_all
  end

  def undetermined_child
    return self if depth == 4

		ms_id = MaterialSpecified.undetermined.id.to_s
		koo_id = KindOfObject.undetermined.id.to_s
		koos_id = KindOfObjectSpecified.undetermined.id.to_s

    if depth == 3
      path_name = self.path + "/#{koos_id}"
    elsif depth == 2
      path_name = self.path + "/#{koo_id}/#{koos_id}"
    elsif depth == 1
      path_name = self.path + "/#{ms_id}/#{koo_id}/#{koos_id}"
    end
    return Path.find_by path: path_name
  end

	# ToDo: Today, name is an alias and result depends on the language setting. Is this still correct and what we want here?
	def last_object_name
		self.objects.last.name
	end

	def to_depth depth
		if self.depth <= depth
			return self
		end
		path = self
		diff = self.depth - depth
		diff.times{path = path.parent}
		return path
	end

	def root?
		self.parent.nil?
	end

	def depth
		self.path.split("/").drop(1).length
	end

	def direct_children
		Path.direct_children(self)
	end

  def direct_children_ids
    direct_children.map(&:id)
  end

  def transitive_children
		Path.transitive_children(self)
  end

  def transitive_children_ids
		transitive_children.map(&:id)
	end

	def self_with_transitive_children
		Path.self_with_transitive_children(self)
	end

	def self_with_transitiv_children
		self_with_transitive_children
	end
  def transitiv_children
		transitive_children
  end

  def transitiv_children_ids
		transitive_children_ids
  end

  def transitive_object_hull
		transitive_children.map(&:last_object)
	end

	def transitiv_object_hull
		transitive_object_hull
	end

	def is_leaf?
		self.depth == 4
	end

	def leafs
		self.transitive_children.select{|p| p.depth == 4}
	end

	def included_or_parent_of? other_paths
		return false unless other_paths.present?
		return parent_of?(other_paths) || [other_paths].flatten.include?(self)
	end

	def parent_of? other_paths
		if other_paths.blank?
			return false
		end
		is_parent = false
		[other_paths].flatten.each do |other_path|
			is_parent = is_parent ||
				other_path.path.starts_with?(self.path) &&
				other_path.depth > self.depth
		end
		return is_parent
	end

	def included_or_child_of? other_paths
		return false unless other_paths.present?
		return child_of?(other_paths) || [other_paths].flatten.include?(self)
	end

	def child_of? other_paths
		return false unless other_paths.present?
		is_child = false
		[other_paths].flatten.each do |other_path|
			is_child = is_child || 
				self.path.starts_with?(other_path.path) &&
				other_path.depth < self.depth
		end
		return is_child
	end

	def parent
		ids = self.ids[0...-1]
		pathname = ""
		ids.each do |id|
			pathname += "/#{id}"
		end
		Path.find_by path: pathname
	end

	def ids
		self.path.split("/").drop(1)
	end

  def last_id
    self.ids.last.to_i
  end

	def objects
		objects = []
		self.ids.each do |id|
			objects << Termlist.find(id)
		end
		return objects
	end

  def last_object
    return objects.last
  end

	def named_path
		named_path = ""
		self.objects.each do |object|
			named_path += "/" + object.name
		end
		return named_path
	end

	private

	def destroy_transitive_children
		begin
			ActiveRecord::Base.transaction do
				self.transitive_children.each(&:destroy!)
			end
		rescue ActiveRecord::RecordNotDestroyed => e
			errors.add(:base, "could not be destroyed because a transitive child (id: #{e.record.id}) could not be destroyed (#{e.record.named_path}).")
			throw(:abort)
		end
	end
end
