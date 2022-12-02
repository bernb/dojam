class KindOfObjectSpecified < Termlist
  before_destroy :abort_if_museum_objects_associated

  def depth
		4
	end
  
  def museum_objects
    paths&.map{|p| p.all_transitive_with_self_museum_objects}&.flatten
  end

  private
  def abort_if_museum_objects_associated
    if museum_objects.any?
      self.errors.add(:base, "could not be destroyed because there are still museum objects associated")
      throw(:abort)
    end
  end
end
