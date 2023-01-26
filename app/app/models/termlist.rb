class Termlist < ApplicationRecord
  include PgSearch::Model
  translates :name
  multisearchable against: :name_en
	# See https://stackoverflow.com/questions/4088532/custom-order-by-explanation for explaination 
	# how the first order parameter gets evaluated and why this works
	default_scope {order(Arel.sql("termlists.name_en = 'undetermined'"), position: :asc, name_en: :asc)}

	# Join table entry should be destroyed for all termlists
	has_many :termlist_paths, dependent: :destroy
	# m/ms/koo/koos will clean up their paths in an separate callback. All other termlists should not destroy the paths
	has_many :paths, through: :termlist_paths
	before_destroy :abort_if_self_is_undetermined_entry # We do not allow removal of undetermined entries

	def self.for_path path
		self
				.unscoped
				.joins(:paths)
				.where("paths.path LIKE ?", path.path + '%')
				.distinct
				.to_a
				.sort{|a, b| a.name_en == 'undetermined' ? 1 : a <=> b}
	end

	def self.use_default_order(termlist)
		return termlist.sort do |a, b|
			if a.name_en == 'undetermined'
				1
			elsif b.name_en == 'undetermined'
				-1
			else
				a.name_en <=> b.name_en
			end
			end
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
    type = self.name
    return Termlist.find_or_create_by name_en: "undetermined", type: type
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

	def self.existing_typenames
		Termlist.select(:type).map(&:type).uniq
	end

  def self.list_types_humanized
    Termlist.pluck(:type)
				.uniq
				.map{|t| Termlist.to_external_type(t)}
				.sort
				.map{|t| t.underscore.gsub('_', ' ')}
	end

	# internal name => external name
	@@typename_mapping = {
			"ExcavationSiteKind" => "KindOfSite",
			"ExcavationSiteCategory" => "KindOfSiteSpecified",
			"Decoration" => "DecorationStyle"
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
	def abort_if_self_is_undetermined_entry
		if name_en == 'undetermined'
			errors.add(:base, 'Removal of undetermined entry is not alliowed')
			throw(:abort)
	end
	end
end
