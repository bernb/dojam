id = ENV.fetch("id")

architectural_element = TermlistKindOfObject.where(name: "architectural element")
                                            .where(termlist_material_specified: TermlistMaterialSpecified
                                              .where(id: id))
                                            .first
architectural_element_kind_specifieds = ["tesserae", "window pane", "undetermined"]  
architectural_element_kind_specifieds.each do |kind|
  k = TermlistKindOfObjectSpecified.create name: kind
  architectural_element.termlist_kind_of_object_specifieds << k
end
