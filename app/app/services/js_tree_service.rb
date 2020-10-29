class JsTreeService
  def self.create_museum_object_node_from_path path
    museum_object_count = path.all_transitive_museum_objects.count + path.all_museum_objects.count
    mo_node = {
        "id": "M" + path.id.to_s,
        "text": museum_object_count.to_s + " " + I18n.t("museum object".pluralize(museum_object_count)),
        "children": false,
        "type": "museum_object"}
    return mo_node
  end

  def self.create_termlist_node_from_path path
    museum_object_count = path.all_transitive_museum_objects.count + path.all_museum_objects.count
    node_id = "N" + path.path.gsub('/', '-')
    node = {"id": node_id, "text": path.last_object_name + " (#{museum_object_count})", "children": true}
    return node
  end
end