class MaterialSpecified < Termlist
  scope :material, ->(m_id) {joins(:paths).where("paths.path LIKE ?", "/#{m_id}%")}
  has_many :material_specified_museum_objects
  has_many :museum_objects, through: :material_specified_museum_objects

  def self.ransackable_scopes(auth_object = nil)
    [:material]
  end

	def depth
		2
	end

	def material
		self.paths.first.objects[0]
	end

	def kind_of_objects
		# We query KindOfObject to get the default scope and therefore
		# correct order of results
		children_paths = self.paths.first.direct_children.map(&:path)
		kind_of_objects = KindOfObject.joins(:paths).where(paths: {path: children_paths})
		return kind_of_objects
	end
end
