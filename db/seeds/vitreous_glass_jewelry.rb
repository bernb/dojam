id = ENV.fetch("id")

jewelry = TermlistKindOfObject.where(name: "jewelry")
                              .where(termlist_material_specified: TermlistMaterialSpecified
                                .where(id: id))
                              .first
jewelry_kind_specifieds = ["bangle", "bead", "pendant", "undetermined"]                              
jewelry_kind_specifieds.each do |kind|
  kind_of_object = TermlistKindOfObjectSpecified.create name: kind
  jewelry.termlist_kind_of_object_specifieds << kind_of_object
end
