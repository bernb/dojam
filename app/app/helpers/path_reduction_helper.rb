module PathReductionHelper
  def self.call
    result = []
    list_hash = {}
    material_groups = PathReductionHelper.group Path.depth(1)
    material_groups.each do |material_group|
      # We assume only one single material per list/file/transitive hull
      material_name = material_group.first.last_object.name.to_s
      # Every member of group has same children as we grouped by transitive hull
      material_specified_groups = PathReductionHelper.group material_group.first.direct_children
      material_specified_groups.each do |material_specified_group|
        list_hash["material_name"] = material_name
        list_hash["material_specifieds"] = material_specified_group.map(&:last_object).map(&:name).reject{|name| name == "undetermined"}
        list_hash["kind_of_objects"] = {}
        kind_of_object_paths = material_specified_group.first.direct_children
        kind_of_object_paths.each do |kind_of_object_path|
          kind_of_object_name = kind_of_object_path.last_object.name
          if kind_of_object_name == "undetermined"
            next
          end
          list_hash["kind_of_objects"][kind_of_object_name] = kind_of_object_path.direct_children.map(&:last_object).map(&:name).reject{|name| name == "undetermined"}
        end
        result << list_hash
        list_hash = {}
      end
    end
    return result
  end

  private
  def self.group paths
    # We check two things here / Group by two conditions:
    # a) If all objects associated with all children are the same (material, kind of object, ..)
    # b) If associated termlists are the same. As we only look at objects in a), we lose information and /A/B/C/D might have other termlist associations than /X/B/C/D
    paths
      .group_by{|path| [path.transitive_object_hull.to_set,
                           path.transitive_children.map(&:termlists).flatten.to_set]}
      .values
  end

end
