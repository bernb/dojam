class Material < Termlist
  # ToDo: Avoid after_create callback that change self (see below)
  # Changing self within an after_create callback can be problematic, is a known limitation of Rails and has produced
  # nasty bugs in the past (i.e. this callback MUST be after has_many)
  # See https://github.com/rails/rails/pull/38166 and the warning
  # at https://guides.rubyonrails.org/active_record_callbacks.html#available-callbacks
  after_create :add_default_path

	def depth
		1
	end

  def transitive_paths
    Path.material_id(self.id)
  end

  def path
    self.paths.first
  end

  def museum_objects
    paths = self.transitive_paths
    secs = MuseumObject.joins(secondary_paths: :termlists).where(paths: {id: paths.ids}).where(termlists: {id: self.id})
    mains = MuseumObject.where(main_path: paths)
    mains + secs
    # ToDo: Why does this not work? -> join table path <-> mu only used for main_path, but still seems to be wrong?
    #self.paths.map{|p| p.museum_objects}.reject(&:empty?).flatten
  end

	def material_specifieds
		# We query MaterialSpecified to get the default scope and therefore
		# correct order of results
		children_paths = self.transitive_paths.first.direct_children.map(&:path)
		material_specifieds = MaterialSpecified.joins(:paths).where(paths: {path: children_paths}) 
		return material_specifieds
  end

  private
  # Materials have no parents but a path to themselves i.e.
  # material always has path /material.id
  # ToDo: Why is that needed? Such a callback is unexpected and did break things when seeding
  # ToDo: Create a unified way to create those base terms (m/ms/koo/koos) i.e. demand enough information on create so that a path can be created
  def add_default_path
    path = Path.create path: "/" + self.id.to_s
    self.paths << path
  end
end
