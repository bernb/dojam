class MaterialSpecified < Termlist
  include MMsKooKoos
  # ToDo: Always create a path to itself as an after_create callback as we might end up with a term without any path
  # which might break things
  scope :material, ->(m_id) {joins(:paths).where("paths.path LIKE ?", "/#{m_id}%")}
  attr_reader :material, :merge_into_ms # Used in active_admin to merge into other model
  before_destroy :destroy_transitive_children

  def self.ransackable_scopes(auth_object = nil)
    [:material]
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
end
