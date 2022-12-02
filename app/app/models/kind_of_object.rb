class KindOfObject < Termlist
	before_destroy :abort_if_museum_objects_associated

	def depth
		3
	end

	def path
		self.paths.first
	end

  def museum_objects
		paths&.map{|p| p.all_transitive_with_self_museum_objects}&.flatten
  end

	def kind_of_object_specifieds material_specified: 
		ms_id = material_specified.id
		paths = Path.where("path SIMILAR TO ?", "/\\d{1,}/#{ms_id}/#{self.id}/%")
		koos = paths.map{|p| p.objects[3]}
    return koos.uniq
	end

	private
	def abort_if_museum_objects_associated
		if museum_objects.any?
			self.errors.add(:base, "could not be destroyed because there are still museum objects associated")
			throw(:abort)
		end
	end
end
