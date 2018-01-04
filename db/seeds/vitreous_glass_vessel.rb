id = ENV.fetch("id")

jewelry = TermlistKindOfObject.where(name: "vessel")
                              .where(termlist_material_specified: TermlistMaterialSpecified
                                .where(id: id))
                              .first
vessel_kind_specifieds = ["labastron", "balsamarium", "bowl", "dish", "double balsamarium",
                          "flask", "goblet","jar", "jug", "lamp", "plate", "undetermined"]                            
vessel_kind_specifieds.each do |kind|
  kind_of_object = TermlistKindOfObjectSpecified.create name: kind
  vessel.termlist_kind_of_object_specifieds << kind_of_object
end
