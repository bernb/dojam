class CustomReports

  def self.materials(properties)
    # raw sql join because we have two associations with museum_objects
    # this returns a hash with material ids as keys and
    # same id as value array, so we can count the value array afterwards
    ids = Path.joins("INNER JOIN museum_objects ON museum_objects.main_path_id = paths.id")
      .pluck(:path)
      .map{|p| p.split('/').second}
      .group_by{|id| id.to_i}
    ids.each{|k, v| ids[k] = v.count}
    ids.transform_keys{|key| Material.find(key).name}
  end

  def self.storages(properties)
    Storage.joins(storage_locations: :museum_objects).group('storages.name').count
  end
end
