class Path < ApplicationRecord
	has_many :termlist_paths
	has_many :termlists, through: :termlist_paths

	def attach object
		self.path + "/" + object.id.to_s
	end
end
