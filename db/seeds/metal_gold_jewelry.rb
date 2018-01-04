id = ENV.fetch("id")

jewelry = TermlistKindOfObject.where(name: "jewelry")
                              .where(termlist_material_specified: TermlistMaterialSpecified
                                .where(id: id))
                              .first
                              

jewelry_koos = ["bangle", "earring", "finger ring", "pendant"]
jewelry_koos.each do |kind|
  k = TermlistKindOfObjectSpecified.create name: kind
  jewelry.termlist_kind_of_object_specifieds << k
end                              
