class JsTreeService
  def self.node_id_to_path tree_id
    path_id = tree_id.match(/\d+/).to_s
    return Path.find path_id
  end

  def self.create_museum_object_node_from_path(path)
    museum_object_count = path.all_transitive_museum_objects.count + path.all_museum_objects.count
    mo_node = {
        "id": self.create_node_id("M", path),
        "text": museum_object_count.to_s + " " + I18n.t("museum object".pluralize(museum_object_count)),
        "children": false,
        "type": "museum_object"}
    return mo_node
  end

  def self.create_termlist_node_from_path(path)
    museum_object_count = path.all_transitive_museum_objects.count + path.all_museum_objects.count
    node = {"id": self.create_node_id("N", path),
            "text": path.last_object_name + " (#{museum_object_count})",
            "children": true}
    return node
  end

  def self.create_termlist_parent_from_path path

  end

  private
  def self.create_node_id(prefix, path)
    return prefix + path.id.to_s
  end
end