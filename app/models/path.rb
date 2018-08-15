class Path < ApplicationRecord
	has_many :termlist_paths
	has_many :termlists, through: :termlist_paths

	def attach object
		self.path + "/" + object.id.to_s
	end

	def named_path
		ids = self.path.split("/").drop(1)
		named_path = ""
		ids.each do |id|
			named_path += "/" + Termlist.find(id).name
		end
		return named_path
	end

end
