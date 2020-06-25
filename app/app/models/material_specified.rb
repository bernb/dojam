class MaterialSpecified < Termlist
  scope :material, ->(m_id) {joins(:paths).where("paths.path LIKE ?", "/#{m_id}%")}
  attr_reader :material, :merge_into_ms # Used in active_admin to merge into other model

  def self.ransackable_scopes(auth_object = nil)
    [:material]
  end

	def depth
		2
	end

  def merge_into other
    # Rewrite paths, if encounter duplicates:
    #  * Copy termlist associations
    #  * Copy museum_objects (main and secondary)
    #  * Remove path
    old_id = self.id.to_s
    new_id = other.id.to_s
    new_pathnames = self.paths.first
      .transitive_children
      .map(&:path)
      .map{|s| s.sub(old_id, new_id)}
    duplicates = self.paths.first
      .transitive_children
      .select{|p| Path.find_by(path: p.path.sub(old_id, new_id)).present?}
    non_duplicates = self.paths.first
      .transitive_children
      .select{|p| Path.find_by(path: p.path.sub(old_id, new_id)).blank?}

    non_duplicates.each do |non_dup|
      non_dup.path = non_dup.path.sub(old_id, new_id)
      non_dup.save
    end

    duplicates.each do |dup|
      old_path = Path.find_by(path: dup.path.sub(new_id, old_id))
      new_path = Path.find_by(path: self.paths.first.path.sub(old_id, new_id))
      old_path.move_all_from(new_path)
    end
    self.paths.delete_all
    self.delete
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
		self.paths.first.objects[0]
	end

	def kind_of_objects
		# We query KindOfObject to get the default scope and therefore
		# correct order of results
		children_paths = self.paths.first.direct_children.map(&:path)
		kind_of_objects = KindOfObject.joins(:paths).where(paths: {path: children_paths})
		return kind_of_objects
	end
end
