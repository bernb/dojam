class KindOfObject < Termlist
	before_destroy :abort_if_museum_objects_associated

	def museum_objects_associated?
		return false unless path.present?
		paths.map{|p| p.all_transitive_with_self_museum_objects}&.flatten.any?
	end
	def depth
		3
	end

	def path
		self.paths.first
	end

  def museum_objects
    paths = Path.depth(3)
      .last_id(self.id)
      .map(&:direct_children)
      .flatten
      .uniq
    as_main = MuseumObject.where(main_path: paths)
    as_secondary = paths.map(&:museum_objects).flatten.uniq
    return as_main + as_secondary
  end

	def kind_of_object_specifieds material_specified: 
		ms_id = material_specified.id
		paths = Path.where("path SIMILAR TO ?", "/\\d{1,}/#{ms_id}/#{self.id}/%")
		koos = paths.map{|p| p.objects[3]}
    return koos.uniq
	end

	private
	def abort_if_museum_objects_associated
		if museum_objects_associated?
			self.errors.add(:base, "could not be destroyed because there are still museum objects associated")
			throw(:abort)
		end
	end
end
