class Path < ApplicationRecord
	has_many :termlist_paths
	has_many :termlists, through: :termlist_paths
	has_many :museum_object_paths
	has_many :museum_objects, through: :museum_object_paths
	scope :last_id, ->(id) {where "path like ?", "%/#{id}"}
	scope :depth, ->(depth) {where "path similar to ?", "/\\d{1,}" * depth}
	scope :default_order, -> {joins(:termlists)
		.order(Arel.sql("termlists.name = 'undetermined'"))
		.order(Arel.sql('termlists.name'))}
	scope :materials, ->{depth(1).default_order}
	scope :material_id, ->(id){where "path like ?", "%/#{id}%"}
	scope :material_specifieds, ->{depth(2).default_order}
	scope :kind_of_objects, ->{depth(3).default_order}
	scope :kind_of_object_specifieds, ->{depth(4).default_order}

	def self.undetermined_path
		m_id = Material.find_by(name: "undetermined").id.to_s
		ms_id = MaterialSpecified.find_by(name: "undetermined").id.to_s
		koo_id = KindOfObject.find_by(name: "undetermined").id.to_s
		koos_id = KindOfObjectSpecified.find_by(name: "undetermined").id.to_s

		return Path.find_by path: "/#{m_id}/#{ms_id}/#{koo_id}/#{koos_id}"
	end

  def undetermined_child
    return self if depth == 4

		ms_id = MaterialSpecified.find_by(name: "undetermined").id.to_s
		koo_id = KindOfObject.find_by(name: "undetermined").id.to_s
		koos_id = KindOfObjectSpecified.find_by(name: "undetermined").id.to_s

    if depth == 3
      path_name = self.path + "/#{koos_id}"
    elsif depth == 2
      path_name = self.path + "/#{koo_id}/#{koos_id}"
    elsif depth == 1
      path_name = self.path + "/#{ms_id}/#{koo_id}/#{koos_id}"
    end
    return Path.find_by path: path_name
  end

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
		path_name = self.path + "/\\d{1,}"
		Path.where("path SIMILAR TO ?", path_name)
	end

  def transitiv_children_ids
    path_name = self.path + "/%"
    Path.where("path LIKE ?", path_name)
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

end
