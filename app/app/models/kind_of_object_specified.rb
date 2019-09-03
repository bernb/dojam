class KindOfObjectSpecified < Termlist
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
end
