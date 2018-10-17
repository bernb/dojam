class Path < ApplicationRecord
	has_many :termlist_paths
	has_many :termlists, through: :termlist_paths

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
