stone = TermlistMaterial.where(name: "stone").first

stone_material_specifieds = ["flint", "carnelian", "limestone", "basalt", "mabre"]
stone_material_specifieds.each do |material|
  m = TermlistMaterialSpecified.create name: material
  stone.termlist_material_specifieds << m
end
