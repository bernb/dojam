module MMsKooKoos
  extend ActiveSupport::Concern

  included do
    before_destroy :abort_if_museum_objects_associated
  end

  def path
    self.paths.first
  end

  def museum_objects
    path&.all_transitive_with_self_museum_objects
  end

  private
  def abort_if_museum_objects_associated
    if museum_objects.present? && museum_objects.any?
      self.errors.add(:base, "could not be destroyed because there are still museum objects associated")
      throw(:abort)
    end
  end

  def cleanup_paths
    self.paths.destroy_all
  end
end
