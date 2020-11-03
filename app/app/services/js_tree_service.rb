class JsTreeService

  def self.build_termlists_for node_id
    path = JsTreeService.node_id_to_path node_id
    nodes = []
    Termlist.path_dependent_descendants.each do |t_class|
      term_count = t_class.for_path(path).count
      human_classname = t_class.to_s.underscore.humanize(capitalize: false).pluralize(term_count)
      nodes << self.create_node(id: self.create_node_id(t_class.to_s, path),
                                text: human_classname + ':' + ' ' + term_count.to_s)
    end
    return nodes
  end

  def self.build_root
    paths = Path.depth(1)
    self.main_nodes_for(paths)
  end

  def self.build_main_for node_id
    nodes = []
    path = JsTreeService.node_id_to_path node_id
    paths = path.direct_children
    nodes << JsTreeService.museum_object_node_from_path(path)
    nodes << JsTreeService.termlist_parent_node_from_path(path)
    nodes += JsTreeService.main_nodes_for(paths)
  end

  private

  def self.node_id_to_path tree_id
    path_id = tree_id.match(/\d+/).to_s
    return Path.find path_id
  end

  def self.museum_object_node_from_path(path)
    museum_object_count = path.all_transitive_museum_objects.count + path.all_museum_objects.count
    return self.create_node(id: self.create_node_id("M", path),
                            text: museum_object_count.to_s + " " + I18n.t("museum object".pluralize(museum_object_count)),
                            children: false,
                            type: "museum_object")
  end

  def self.main_node_from_path(path)
    museum_object_count = path.all_transitive_museum_objects.count + path.all_museum_objects.count
    return self.create_node(id: self.create_node_id("N", path),
                            text: path.last_object_name + " (#{museum_object_count})",
                            children: true)
  end

  def self.termlist_parent_node_from_path(path)
    return self.create_node(id: self.create_node_id("TP", path),
                            text: I18n.t("termlists"),
                            children: true,
                            type: "termlist-parent")
  end

  def self.termlist_node_from_path path

  end

  def self.prefix_of(node_id)
    return node_id.match(/^[#\w]+/).to_s
  end

  def self.main_nodes_for(paths)
    nodes = []
    PathService.sort_by_last_object_name(paths).each do |c_path|
      nodes << JsTreeService.main_node_from_path(c_path)
    end
    return nodes
  end

  def self.create_node(id:, text:, children: false, type: nil)
    node_hash = {
        "id": id,
        "text": text,
        "children": children}
    type.present?
    node_hash["type"] = type
    return node_hash
  end

  def self.create_node_id(prefix, path)
    return prefix + '-' + path.id.to_s
  end
end