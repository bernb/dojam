class MaterialSpecified < Termlist
  scope :material, ->(m_id) {joins(:paths).where("paths.path LIKE ?", "/#{m_id}%")}
  attr_reader :material, :merge_into_ms # Used in active_admin to merge into other model

  def self.ransackable_scopes(auth_object = nil)
    [:material]
  end

  def path
    self.paths.first
  end

	def depth
		2
	end

  def merge_into other
    other.paths.first.move_all_from(self.paths.first)
    if other.save
      self.paths.delete_all
      self.delete
      return true
    else
      return false
    end
  end

  def museum_objects
    paths = self
      .paths.map{|p| p.transitiv_children}
      .flatten
      .select{|p| p.depth == 4}
    path_ids = paths.map(&:id)
    secs = MuseumObject
      .joins(secondary_paths: :termlists)
      .where(paths: {id: path_ids})
      .where(termlists: {id: self.id})
    mains = MuseumObject.where(main_path: paths)
    mains + secs
  end

	def material
    self.paths&.first&.objects&.fetch(0)
	end

	def kind_of_objects
		# We query KindOfObject to get the default scope and therefore
		# correct order of results
		children_paths = self.paths.first.direct_children.map(&:path)
		kind_of_objects = KindOfObject.joins(:paths).where(paths: {path: children_paths})
		return kind_of_objects
	end
end
