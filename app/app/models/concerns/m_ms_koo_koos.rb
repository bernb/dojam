module MMsKooKoos
  extend ActiveSupport::Concern

  included do
    # Note that the order of the callbacks matter as after cleaning up the paths there will be no associated museum objects
    # That's also why we prepend the callbacks, so that the default dependent: :destroy action on termlist_paths association triggers after them
    # So the resulting order is: abort_if_mo_associated, cleanup_paths, dependent: :destroy
    before_destroy :cleanup_paths, prepend: true
    before_destroy :abort_if_museum_objects_associated, prepend: true
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
