class Termlist < ApplicationRecord
	# See https://stackoverflow.com/questions/4088532/custom-order-by-explanation for explaination 
	# how the first order parameter gets evaluated and why this works
	default_scope {order("termlists.name = 'undetermined'", position: :asc, name: :asc)}
	after_save :add_default_path_for_roots, on: :create
	has_many :termlist_paths
	has_many :paths, through: :termlist_paths

	def depth
		5
	end

	# Some termlists do no actually have any paths,
	# those are valid choices for all of them
	def self.is_independent_of_paths
		false
	end

	private
	# Materials have no parents but a path to themselves i.e.
	# material always has path /material.id
	def add_default_path_for_roots
		if self.depth == 1
			path = Path.find_or_create_by path: "/" + self.id.to_s
			self.paths << path
		end
	end
end
