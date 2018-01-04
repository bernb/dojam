id = ENV.fetch("id")

quartz = TermlistMaterialSpecified.where(name: "quartz quartz")
                                 .where(termlist_material: TermlistMaterial
                                   .where(id: id))
                                 .first

quartz_productions = ["hand made", "mold made", "undetermined"]

quartz_productions.each do |production|
  p = TermlistProduction.create name: production
  quartz.termlist_productions << p
end

quartz_colors = ["beige", "grey", "white", "undetermined"]

quartz_colors.each do |color|
  c = TermlistColor.create name: color
  quartz.termlist_colors << c
end

quartz_decorations = ["cutting", "drilling", "glazing", "painting", "undetermined"]

quartz_decorations.each do |decoration|
  d = TermlistDecoration.create name: decoration
  quartz.termlist_decorations << d
end

quartz_decoration_colors = ["turquoise", "white", "none", "undetermined"]

quartz_decoration_colors.each do |deco_color|
  d = TermlistDecorationColor.create name: deco_color
  quartz.termlist_decoration_colors << d
end

quartz_inscription_letter = ["Arabic", "Kufic", "undetermined"]

quartz_inscription_letter.each do |inscription|
  i = TermlistInscriptionLetter.create name: inscription
  quartz.termlist_inscription_letters << i
end

quartz_inscription_languages = ["Arabic", "undetermined"]

quartz_inscription_languages.each do |inscription|
  i = TermlistInscriptionLanguage.create name: inscription
  quartz.termlist_inscription_languages << i
end
