class MaterialSpecified < Termlist
  # ToDo: Always create a path to itself as an after_create callback as we might end up with a term without any path
  # which might break things
  scope :material, ->(m_id) {joins(:paths).where("paths.path LIKE ?", "/#{m_id}%")}
  attr_reader :material, :merge_into_ms # Used in active_admin to merge into other model
  before_destroy :abort_if_museum_objects_associated
  before_destroy :destroy_transitive_children

  def museum_objects_associated?
    return false unless path.present?
    path.all_transitive_with_self_museum_objects.any?
  end

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

  private
  def destroy_transitive_children
    path = self.path
    if path.blank?
      warn("model did not have any associated paths. This should never happen. Check associated yaml files for unusual errors.")
      return
    end
    path.destroy
    if path.errors.any?
      errors.add(:base, "could not be destroyed because a (transitive) child path could not be destroyed")
      throw(:abort)
    end
  end

  def abort_if_museum_objects_associated
    if museum_objects_associated?
      self.errors.add(:base, "could not be destroyed because there are still museum objects associated")
      throw(:abort)
    end
  end
end
