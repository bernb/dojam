ceramic = TermlistMaterial.where(name: "ceramic").first

ceramic_material_specifieds = ["khirbet kerak ware", "metal ware", "porcelain", "white_slip_ware", "terra sigillata"]
ceramic_material_specifieds.each do |material|
  m = TermlistMaterialSpecified.create name: material
  ceramic.termlist_material_specifieds << m
end
