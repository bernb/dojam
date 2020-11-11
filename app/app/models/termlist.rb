class Termlist < ApplicationRecord
  include PgSearch::Model
  translates :name
  multisearchable against: :name_en
	# See https://stackoverflow.com/questions/4088532/custom-order-by-explanation for explaination 
	# how the first order parameter gets evaluated and why this works
	default_scope {order(Arel.sql("termlists.name_en = 'undetermined'"), position: :asc, name_en: :asc)}
	after_create :add_default_path_for_roots
	has_many :termlist_paths
	has_many :paths, through: :termlist_paths

	def self.for_path path
		self
				.unscoped
				.joins(:paths)
				.where("paths.path LIKE ?", path.path + '%')
				.distinct
				.to_a
				.sort{|a, b| a.name_en == 'undetermined' ? 1 : a <=> b}
	end

	def self.path_dependent_descendants
		# We are only interested in those classes that depend on those classes:
		path_classes = [
				Material,
				MaterialSpecified,
				KindOfObject,
				KindOfObjectSpecified
		]
		return Termlist
							 .pluck(:type)
							 .uniq
							 .sort
							 .map(&:constantize)
							 .reject(&:is_independent_of_paths)
							 .reject{|c| c.in? path_classes}
	end

  def self.undetermined
    type = self.first.type
    return Termlist.find_by name_en: "undetermined", type: type
  end

	def depth
		5
	end

  def to_s
    name
  end

	# Some termlists do no actually have any paths,
	# those are valid choices for all of them
	def self.is_independent_of_paths
		false
	end

  def self.list_types_humanized
    Termlist.pluck(:type)
				.uniq
				.sort
				.map{|t| Termlist.to_external_type(t)}
				.map{|t| t.underscore.gsub('_', ' ')}
	end

	@@typename_mapping = {
			"ExcavationSiteKind" => "KindOfSite",
			"ExcavationSiteCategory" => "KindOfSiteSpecified"
	}

	# Helper method for Termlist.list_types_humanized, as for some termlists database type does not match with
	# the name shown to the user
	def self.to_internal_type(typename)
		if @@typename_mapping.invert.has_key?(typename)
			return @@typename_mapping.invert[typename]
		else
			return typename
		end
	end

	def self.to_external_type(typename)
		if @@typename_mapping.has_key?(typename)
			return @@typename_mapping[typename]
		else
			return typename
		end
	end

	private
	# Materials have no parents but a path to themselves i.e.
	# material always has path /material.id
	def add_default_path_for_roots
		if self.depth == 1
			path = Path.find_or_create_by path: "/" + self.id.to_s
		end
	end
end
