# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

museum = Museum.create name: "JAM", prefix: "J"

storages = []

('A'..'D').each do |n|
  storage = Storage.create name: "Hall " + n.to_s
  storages.push storage
end

storages.each do |storage|
  (1..30).each do |n|
  letter = storage.name[-1] # counts backwards the string thus gets the last char
  location = StorageLocation.create name: "showcase " + letter + n.to_s
  storage.storage_locations << location
  end
end

museum.storages << storages

museum.save!


TermlistAcquisitionKind.create name: "chance find"
TermlistAcquisitionKind.create name: "confiscation"
TermlistAcquisitionKind.create name: "excavation"
TermlistAcquisitionKind.create name: "gift"
TermlistAcquisitionKind.create name: "purchase"
TermlistAcquisitionKind.create name: "unknown"

TermlistAcquisitionDeliveredBy.create name: "excavator"
TermlistAcquisitionDeliveredBy.create name: "donor"
TermlistAcquisitionDeliveredBy.create name: "seller"
TermlistAcquisitionDeliveredBy.create name: "institution"
TermlistAcquisitionDeliveredBy.create name: "unknown"

ceramic = TermlistMaterial.create name: "ceramic"
metal = TermlistMaterial.create name: "metal"
organic = TermlistMaterial.create name: "organic material"
stone = TermlistMaterial.create name: "stone"
vitreous = TermlistMaterial.create name: "vitreous material"

# ceramics
khirbet_kerak_ware   =  TermlistMaterialSpecified.create name: "khirbet kerak ware"
metal_ware   =  TermlistMaterialSpecified.create name: "metal ware"
porcelain   =  TermlistMaterialSpecified.create name: "porcelain"
white_slip_ware   =  TermlistMaterialSpecified.create name: "white_slip_ware"
terra_sigillata   =  TermlistMaterialSpecified.create name: "terra sigillata"

# metal
silver =  TermlistMaterialSpecified.create name: "silver"
gold   =  TermlistMaterialSpecified.create name: "gold"
iron   =  TermlistMaterialSpecified.create name: "iron"
copper   =  TermlistMaterialSpecified.create name: "copper"
lead   =  TermlistMaterialSpecified.create name: "lead"

# organic
amber   =  TermlistMaterialSpecified.create name: "amber"
antler   =  TermlistMaterialSpecified.create name: "antler"
bone_animal   =  TermlistMaterialSpecified.create name: "bone animal"
bone_human   =  TermlistMaterialSpecified.create name: "bone human"
charcoal   =  TermlistMaterialSpecified.create name: "charcoal"
coral   =  TermlistMaterialSpecified.create name: "coral"
hair   =  TermlistMaterialSpecified.create name: "hair"
horn   =  TermlistMaterialSpecified.create name: "horn"

#stone
flint   =  TermlistMaterialSpecified.create name: "flint"
carnelian   =  TermlistMaterialSpecified.create name: "carnelian"
limestone   =  TermlistMaterialSpecified.create name: "limestone"
basalt   =  TermlistMaterialSpecified.create name: "basalt"
mabre   =  TermlistMaterialSpecified.create name: "mabre"

# vitreous
glass   =  TermlistMaterialSpecified.create name: "glass"
frit   =  TermlistMaterialSpecified.create name: "quartz frit"
egyptian_blue   =  TermlistMaterialSpecified.create name: "Egyptian blue"
undetermined   =  TermlistMaterialSpecified.create name: "undetermined"

ceramic.termlist_material_specifieds << khirbet_kerak_ware
ceramic.termlist_material_specifieds << metal_ware
ceramic.termlist_material_specifieds << porcelain
ceramic.termlist_material_specifieds << white_slip_ware
ceramic.termlist_material_specifieds << terra_sigillata

metal.termlist_material_specifieds << gold
metal.termlist_material_specifieds << silver
metal.termlist_material_specifieds << iron
metal.termlist_material_specifieds << copper
metal.termlist_material_specifieds << lead

organic.termlist_material_specifieds << amber
organic.termlist_material_specifieds << antler
organic.termlist_material_specifieds << bone_animal
organic.termlist_material_specifieds << bone_human
organic.termlist_material_specifieds << charcoal
organic.termlist_material_specifieds << coral
organic.termlist_material_specifieds << hair
organic.termlist_material_specifieds << horn

stone.termlist_material_specifieds << flint
stone.termlist_material_specifieds << carnelian
stone.termlist_material_specifieds << limestone
stone.termlist_material_specifieds << basalt
stone.termlist_material_specifieds << mabre

vitreous.termlist_material_specifieds << glass
vitreous.termlist_material_specifieds << frit
vitreous.termlist_material_specifieds << egyptian_blue
vitreous.termlist_material_specifieds << undetermined



TermlistAuthenticity.create name: "archaeological object"
TermlistAuthenticity.create name: "copy"
TermlistAuthenticity.create name: "forgery"
TermlistAuthenticity.create name: "unspecific"
TermlistAuthenticity.create name: "unknown"

tomb = TermlistExcavationSiteKind.create name: "tomb"
settlement = TermlistExcavationSiteKind.create name: "settlement"

ExcavationSite.create name: "‘Ain Ghazal", 
                      name_mega_jordan: "AIN GHAZAL", 
                      name_expedition: "‘Ain Ghazal", 
                      site_number_mega: 2710,
                      site_number_jadis: 2415001,
                      site_number_expedition: "",
                      coordinates_mega: "E 35.97735 N 31.99006",
                      termlist_excavation_site_kind: settlement

ExcavationSite.create name: "Tell es-Sa’idiyeh", 
                      name_mega_jordan: "SAIDIYEH", 
                      name_expedition: "Tell es-Sa’idiyeh", 
                      site_number_mega: 2655,
                      site_number_jadis: 2018001,
                      site_number_expedition: "",
                      coordinates_mega: "E 35.57650, N 32.26870",
                      termlist_excavation_site_kind: tomb
                      
                      
vitreous_material_preservation_states = ["corroded", "iridescent", "bottom", "complete", "complete profile", 
                                         "foot", "fragmentary", "handle", "handle-to-wall", "rim", "rim-to-wall", "stem", "wall-to-bottom"]
                                         
vitreous_material_preservation_states.each do |state|
  s = TermlistPreservationState.create name: state
  vitreous.termlist_preservation_states << s
end                                         
                      
                      
                      
                      
stone_kind_of_objects = 
              ["architectural element","balance weight", "bead",
               "cylinder seal", "cosmetic palette", "finger ring", "gravestone",
               "hammer stone", "lamp", "lid", "loom weight", "lower grinding stone",
               "mace head", "mill", "pendant", "quern", "ring", "rubbing stone",
               "scarab", "scraper", "sculpture", "spindle whorl", "stamp seal",
               "stelae", "tile", "tool", "unworked stone", "upper grinding stone",
               "vessel", "whetstone", "undetermined" ]


# Contains WRONG ENTRIES!
metal_kind_of_objects = [ "architectural element","arrowhead","ax","balance weight","bangle","bead","bell","bracelet","brazier", 
                          "brooch", "buckle", "button", "candelabra", "cannon", "chain", "chain armor", "coin", 
                          "compasses", "cosmetic containers", "cosmetic spatula", "cosmetic spoon", "cotter-pin (Splint)" ]

glass_kind_of_objects = ["architectural element", "jewelry", "vessel", "undetermined"]
                          
frit_kind_of_objects = ["cylinder seal"]

                          
#metal_kind_of_objects.each do |kind|
#  TermlistKindOfObject.create name: kind
#end
               
#stone_kind_of_objects.each do |kind|
#  TermlistKindOfObject.create name: kind
#end

glass_kind_of_objects.each do |kind|
  kind = TermlistKindOfObject.create name: kind
  glass.termlist_kind_of_objects << kind
end

frit_kind_of_objects.each do |kind|
  TermlistKindOfObject.create name: kind
end


architectural_element_kind_specifieds = ["tesserae", "window pane", "undetermined"]                                                
mill_kind_specifieds = ["manually operated mill", "Olynthus mill"]
sculpture_kind_specifieds = ["bust", "head", "relief", "statue"]
bead_kind_specifieds = ["eye bead"]
vessel_kind_specifieds = ["labastron", "balsamarium", "bowl", "dish", "double balsamarium",
                          "flask", "goblet","jar", "jug", "lamp", "plate", "undetermined"]
jewelry_kind_specifieds = ["bangle", "bead", "pendant", "undetermined"]

specifieds = architectural_element_kind_specifieds + mill_kind_specifieds +
             sculpture_kind_specifieds + vessel_kind_specifieds + bead_kind_specifieds +
             vessel_kind_specifieds
 
#ToDo: This is not the proper way to select the correct entry
vessel = TermlistKindOfObject.where(name: "vessel").first
vessel_kind_specifieds.each do |kind|
  kind_of_object = TermlistKindOfObjectSpecified.create name: kind
  vessel.termlist_kind_of_object_specifieds << kind_of_object
end 
             
jewelry = TermlistKindOfObject.where(name: "jewelry").first
jewelry_kind_specifieds.each do |kind|
  kind_of_object = TermlistKindOfObjectSpecified.create name: kind
  jewelry.termlist_kind_of_object_specifieds << kind_of_object
end
            
architectural_element = TermlistKindOfObject.where(name: "architectural element").first
architectural_element_kind_specifieds.each do |kind|
  kind_spec = TermlistKindOfObjectSpecified.create name: kind
  architectural_element.termlist_kind_of_object_specifieds << kind_spec
end

#specifieds.each do |specified|
#  TermlistKindOfObjectSpecified.create name: specified
#end
                          
#metal_kind_of_object_specifieds.each do |kind|
#  TermlistKindOfObjectSpecified.create name: kind
#end

metal_productions = [ "annealing", "beating", "casting in a mould", "casting with lost wax technique", "cutting", "drawing", "forging", "hammering", "repousé", "riveting", "smelting", "soldering"]
metal_productions.each do |production|
  TermlistProduction.create name: production
end

metal_decorations = [ "chasing", "differential alloying", "engraving", "filigree", "gilding", "granulation", "inlay", "niello", "patination", "punching", "stamping", "plated"]

#metal_productions.each do |decoration|
#  TermlistDecoration.create name: decoration
#end

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


termlist_preservations = ["complete", "fragmentary"]
termlist_preservations.each do |preservation|
  TermlistPreservation.create name: preservation
end

termlist_conservations = ["no", "yes", "partially", "cleaned", "consolidated", "needed", "unknown"]
termlist_conservations.each do |conservation|
  TermlistConservation.create name: conservation
end

termlist_dating_period = ["Palaeolithic", "Mesolithic", "Neolithic", "Chalcolithic",
                          "Bronze Age", "Early Bronze Age", "Middle Bronze Age",
                          "Late Bronze Age", "Iron Age", "Early Iron Age",
                          "Late Iron Age", "Hellenistic", "Nabataean", "Roman",
                          "Byzantine", "Umayyad", "Abbasid", "Ayyubid", "Mamluk",
                          "Ottoman", "Modern"]

termlist_dating_period.each do |period|
  TermlistDatingPeriod.create name: period
end


termlist_dating_millennium = [ "10th mill. BC", "9th mill. BC", "8th mill. BC", 
                               "7th mill. BC", "6th mill. BC", "5th mill. BC",
                               "4th mill. BC", "3rd mill. BC", "2nd mill. BC",
                               "1st mill. BC", "1st mill. AD", "2nd mill. AD"]

termlist_dating_millennium.each do |millennium|
  TermlistDatingMillennium.create name: millennium
end
