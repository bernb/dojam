class Material < Termlist
	def depth
		1
	end

  def paths
    Path.material_id(self.id)
  end 

  def museum_objects
    paths = self.paths
    secs = MuseumObject.joins(secondary_paths: :termlists).where(paths: {id: paths.ids}).where(termlists: {id: self.id})
    mains = MuseumObject.where(main_path: paths)
    mains + secs
    # ToDo: Why does this not work? -> join table path <-> mu only used for main_path, but still seems to be wrong?
    #self.paths.map{|p| p.museum_objects}.reject(&:empty?).flatten
  end

	def material_specifieds
		# We query MaterialSpecified to get the default scope and therefore
		# correct order of results
		children_paths = self.paths.first.direct_children.map(&:path)
		material_specifieds = MaterialSpecified.joins(:paths).where(paths: {path: children_paths}) 
		return material_specifieds
	end
end
