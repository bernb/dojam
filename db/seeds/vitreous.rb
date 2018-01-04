vitreous = TermlistMaterial.where(name: "vitreous material").first

vitreous_material_specified = ["glass", "quartz frit", "Egyptian blue", "undetermined"]
vitreous_material_specified.each do |material|
  m = TermlistMaterialSpecified.create name: material
  vitreous.termlist_material_specifieds << m
end

ENV["id"] = vitreous.id.to_s
require "#{Rails.root}/db/seeds/vitreous_glass.rb"
ENV["id"] = vitreous.id.to_s
require "#{Rails.root}/db/seeds/vitreous_egyptian.rb"
