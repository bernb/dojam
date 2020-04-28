module PathReductionHelper
  def self.call
    result = []
    list_hash = {}
    material_groups = Path.depth(1)
      .group_by{|path| path.transitive_object_hull.to_set}
      .values
    material_groups.each do |material_group|
      material_name = material_group.first.last_object.name.to_s
      # Every member of group has same children as we grouped by transitive hull
      material_specified_groups = material_group.first
        .direct_children
        .group_by{|path| path.transitive_object_hull.to_set}
        .values
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

end
