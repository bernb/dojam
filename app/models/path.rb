class Path < ApplicationRecord
	has_many :termlist_paths
	has_many :termlists, through: :termlist_paths
	has_many :museum_object_paths
	has_many :museum_objects, through: :museum_object_paths
	scope :last_id, ->(id) {where "path like ?", "%/#{id}"}
	scope :depth, ->(depth) {where "path similar to ?", "/\\d{1,}" * depth}
	scope :materials, ->{depth(1)}
	scope :material_specifieds, ->{depth(2)}
	scope :kind_of_objects, ->{depth(3)}
	scope :kind_of_object_specifieds, ->{depth(4)}

	def self.undetermined_path
		m_id = Material.find_by(name: "undetermined").id.to_s
		ms_id = MaterialSpecified.find_by(name: "undetermined").id.to_s
		koo_id = KindOfObject.find_by(name: "undetermined").id.to_s
		koos_id = KindOfObjectSpecified.find_by(name: "undetermined").id.to_s

		return Path.find_by path: "/#{m_id}/#{ms_id}/#{koo_id}/#{koos_id}"
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

	def parent_of? other_path
		if other_path.nil?
			return false
		end
		other_path.path.starts_with?(self.path) &&
			other_path.depth > self.depth
	end

	def child_of? other_path
		if other_path.nil?
			return false
		end
		self.path.starts_with?(other_path.path) &&
			other_path.depth < self.depth
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

	def objects
		objects = []
		self.ids.each do |id|
			objects << Termlist.find(id)
		end
		return objects
	end

	def named_path
		named_path = ""
		self.objects.each do |object|
			named_path += "/" + object.name
		end
		return named_path
	end

end
