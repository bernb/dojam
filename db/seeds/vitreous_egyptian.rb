egyptian_blue = TermlistMaterialSpecified.where(name: "Egyptian blue")
                                         .where(termlist_material: TermlistMaterial
                                           .where(name: "vitreous material"))
                                         .first
egyptian_blue_kind_of_objects = ["jewelry", "vessel", "undetermined"]  
egyptian_blue_kind_of_objects.each do |kind|
  k = TermlistKindOfObject.create name: kind
  egyptian_blue.termlist_kind_of_objects << k
end   
