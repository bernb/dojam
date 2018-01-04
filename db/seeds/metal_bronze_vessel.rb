id = ENV.fetch("id")

vessel = TermlistKindOfObject.where(name: "vessel")
                              .where(termlist_material_specified: TermlistMaterialSpecified
                                .where(id: id))
                              .first
                              
vessel_kind_of_object_specifieds = ["bowl", "censer", "cosmetic containers"]
vessel_kind_of_object_specifieds.each do |kind|
  k = TermlistKindOfObjectSpecified.create name: kind
  vessel.termlist_kind_of_object_specifieds << k
end                              
