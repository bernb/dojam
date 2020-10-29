class PathService
  def self.sort_by_last_object_name paths
    return paths.sort_by{|p| [p.last_object_name == "undetermined" ? 1 : 0, p.last_object_name]}
  end
end