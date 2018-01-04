id = ENV.fetch("id")

glass = TermlistMaterialSpecified.where(name: "glass")
                                 .where(termlist_material: TermlistMaterial
                                   .where(id: id))
                                 .first
glass_kind_of_objects = ["architectural element", "inlay", "jewelry", "primary product/waste", "vessel", "undetermined"]
glass_kind_of_objects.each do |kind|
  kind = TermlistKindOfObject.create name: kind
  glass.termlist_kind_of_objects << kind
end

glass_productions = ["free-blown", "casting", "core-formed", "mold-blown", "mosaicking", "undetermined"]
glass_productions.each do |production|
  p = TermlistProduction.create name: production
  glass.termlist_productions << p
end

glass_colors = ["colorless", "light yellow", "dark yellow", "light blue", "dark blue", "light turquoise", "dark turquoise", "red", "blue-green", "green-blue", "light green", "dark green", "violet", "light brown", "dark brown"]

glass_colors.each do |color|
  c = TermlistColor.create name: color
  glass.termlist_colors << c
end

glass_decorations = ["applying", "pinching", "pressing", "pulling", "painting", "applying", 
                     "rolling-in", "cutting", "undetermined"]
                     
glass_decorations.each do |decoration|
  d = TermlistDecoration.create name: decoration
  glass.termlist_decorations << d
end    

glass_decoration_color = ["colorless", "light yellow", "dark yellow", "light blue", "dark blue", 
                          "light turquoise", "dark turquoise", "red", "blue-green", "green-blue",
                          "light green", "dark green", "violet", "light brown", "dark brown"]               

glass_decoration_color.each do |dec_color|
  d = TermlistDecorationColor.create name: dec_color
  glass.termlist_decoration_colors << d
end


glass_inscription_letters = ["Arabic", "Kufic", "undetermined"]

glass_inscription_letters.each do |letters|
  l = TermlistInscriptionLetter.create name: letters
  glass.termlist_inscription_letters << l
end

glass_inscription_languages = ["Arabic", "undetermined"]

glass_inscription_languages.each do |lang|
  l = TermlistInscriptionLanguage.create name: lang
  glass.termlist_inscription_languages << l
end



ENV["id"] = glass.id.to_s
require "#{Rails.root}/db/seeds/vitreous_glass_architectural.rb"
ENV["id"] = glass.id.to_s
require "#{Rails.root}/db/seeds/vitreous_glass_jewelry.rb"
ENV["id"] = glass.id.to_s
require "#{Rails.root}/db/seeds/vitreous_glass_vessel.rb"
