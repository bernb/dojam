id = ENV.fetch("id")

silver = TermlistMaterialSpecified.where(name: "silver")
                                 .where(termlist_material: TermlistMaterial
                                   .where(id: id))
                                 .first
                                 
silver_koos = ["coin", "jewelry"]
silver_koos.each do |kind|
  k = TermlistKindOfObject.create name: kind
  silver.termlist_kind_of_objects << k
end                                
