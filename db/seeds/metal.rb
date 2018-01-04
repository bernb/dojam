metal = TermlistMaterial.where(name: "metal").first


metal_productions = ["annealing", "beating", "casting in a mould", "casting with lost wax technique", "cutting", "drawing", "forging", "hammering", "repoussé", "riveting", "smelting", "soldering", "undetermined"]
metal_material_specifieds.each do |material|
  m = TermlistMaterialSpecified.create name: material
  metal.termlist_material_specifieds << m
end


metal_material_specifieds = ["brass", "bronze", "copper", "gold", "iron", "lead", "silver", "steel", "tin", "undetermined"]
metal_decorations = [ "chasing", "differential alloying", "engraving", "filigree", "gilding", "granulation", "inlay", "niello", "patination", "punching", "stamping", "plated"]
metals = metal.termlist_material_specifieds
metals.each do |metal|
  metal_productions.each do |production|
    p = TermlistProduction.create name: production
    metal.termlist_productions << p
  end
  
  metal_decorations.each do |decoration|
    d = TermlistDecoration.create name: decoration
    metal.termlist_decorations << d
  end
end


ENV["id"] = metal.id.to_s
require "#{Rails.root}/db/seeds/metal_bronze.rb"
ENV["id"] = metal.id.to_s
require "#{Rails.root}/db/seeds/metal_gold.rb"
