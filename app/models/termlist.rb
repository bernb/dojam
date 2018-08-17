class Termlist < ApplicationRecord
	default_scope {order(name: :asc)}
	after_save :add_default_path_for_roots, on: :create
	has_many :termlist_paths
	has_many :paths, through: :termlist_paths

	def depth
		5
	end

	# Following searches for i.e. /__/__/23/__
	# No use for now, but stays for now for future reference if needed
#	def direct_children
#		path = "/\\d{1,}" * (self.depth - 1)
#		path = path + "/" + self.id.to_s + "/\\d{1,}"
#		paths = Path.where("path SIMILAR TO ?", path)
#		termlist_ids = []
#		paths.each do |path|
#			termlist_ids << path.path.split("/")[self.depth+1]
#		end
#		Termlist.find termlist_ids
#	end

	# Will create a path for all paths of given object
	def attach_child object
		if self.depth == object.depth - 1
			self.paths.each do |path|
				path = path.attach object
				object.add_path path
			end
		end
	end

	def add_path path
		if path.is_a? String
			p = Path.find_or_create_by path: path
			self.paths << p
		elsif path.is_a? Path
			self.paths << p
		end
	end

	private
	def add_default_path_for_roots
		if self.depth == 1
			path = Path.find_or_create_by path: "/" + self.id.to_s
			self.paths << path
		end
	end
end
