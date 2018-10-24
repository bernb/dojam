class Path < ApplicationRecord
	has_many :termlist_paths
	has_many :termlists, through: :termlist_paths
	scope :last_id, ->(id) {where "path like ?", "%/#{id}"}
	scope :depth, ->(depth) {where "path similar to ?", "/\\d{1,}" * depth}

	def self.undetermined_path
		m_id = Material.find_by(name: "undetermined").id.to_s
		ms_id = MaterialSpecified.find_by(name: "undetermined").id.to_s
		koo_id = KindOfObject.find_by(name: "undetermined").id.to_s
		koos_id = KindOfObjectSpecified.find_by(name: "undetermined").id.to_s

		return Path.find_by path: "/#{m_id}/#{ms_id}/#{koo_id}/#{koos_id}"
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
