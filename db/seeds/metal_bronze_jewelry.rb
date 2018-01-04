id = ENV.fetch("id")

jewelry = TermlistKindOfObject.where(name: "jewelry")
                              .where(termlist_material_specified: TermlistMaterialSpecified
                                .where(id: id))
                              .first
                              
jewelry_kind_of_object_specifieds = ["bangle", "bracelet", "hair pin"]    
jewelry_kind_of_object_specifieds.each do |kind|
  k = TermlistKindOfObjectSpecified.create name: kind
  jewelry.termlist_kind_of_object_specifieds << k
end                               
