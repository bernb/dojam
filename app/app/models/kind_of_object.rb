class KindOfObject < Termlist
	include MMsKooKoos

	def depth
		3
	end

	def kind_of_object_specifieds material_specified: 
		ms_id = material_specified.id
		paths = Path.where("path SIMILAR TO ?", "/\\d{1,}/#{ms_id}/#{self.id}/%")
		koos = paths.map{|p| p.objects[3]}
    return koos.uniq
	end
end
