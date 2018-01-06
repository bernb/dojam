organic = TermlistMaterial.where(name: "organic material").first

organic_material_specifieds = ["amber", "antler", "bone animal", "bone human", "charcoal", "coral", "hair", "horn"]
organic_material_specifieds.each do |material|
  m = TermlistMaterialSpecified.create name: material
  organic.termlist_material_specifieds << m
end
