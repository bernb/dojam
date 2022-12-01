class KindOfObjectSpecified < Termlist
  before_destroy :abort_if_museum_objects_associated
  def museum_objects_associated?
    return false unless path.present?
    paths.map{|p| p.all_transitive_with_self_museum_objects}&.flatten.any?
  end
  def depth
		4
	end
  
  def museum_objects
    paths = Path.depth(4)
      .last_id(self.id)
    as_main = MuseumObject.where(main_path: paths)
    as_secondary = paths.map(&:museum_objects).flatten.uniq
    return as_main + as_secondary
  end

  private
  def abort_if_museum_objects_associated
    if museum_objects_associated?
      self.errors.add(:base, "could not be destroyed because there are still museum objects associated")
      throw(:abort)
    end
  end
end
