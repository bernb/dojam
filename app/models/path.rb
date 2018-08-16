class Path < ApplicationRecord
	has_many :termlist_paths
	has_many :termlists, through: :termlist_paths
	scope :find_in_depth_one, ->(id){where("path = ?", "/#{id}")}
	# Note that we assume a 1:n association between depth one and two thus the following always returns a single entry
	scope :find_in_depth_two, ->(id){where("path SIMILAR TO ?", "/\\d{1,}/#{id}")}

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

	def attach object
		self.path + "/" + object.id.to_s
	end

	def named_path
		named_path = ""
		self.objects.each do |object|
			named_path += "/" + object.name
		end
		return named_path
	end

end
