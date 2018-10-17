class Path < ApplicationRecord
	has_many :termlist_paths
	has_many :termlists, through: :termlist_paths

	def down_to_depth target_depth
		if target_depth >= self.depth
			return self
		end
		pathname = self.path
		regexp_str = "\/\\d{1,}" * target_depth 
		puts regexp_str
		regexp = Regexp.new regexp_str
		pathname = pathname[regexp]
		puts pathname
		Path.find_by path: pathname
	end

	def depth
		self.path.split("/").drop(1).length
	end

	def direct_children
		path_name = self.path + "/\\d{1,}"
		Path.where("path SIMILAR TO ?", path_name)
	end

	def parent
		# This is dirty, we cut the end of the path_name here
		path_name = self.path.reverse.split("/",2)[1].reverse
		Path.find_by path: path_name
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
