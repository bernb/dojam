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


### Materials ###

ceramic = TermlistMaterial.create name: "ceramic"
metal = TermlistMaterial.create name: "metal"
organic = TermlistMaterial.create name: "organic material"
stone = TermlistMaterial.create name: "stone"
vitreous = TermlistMaterial.create name: "vitreous material"

require "#{Rails.root}/db/seeds/vitreous.rb"
require "#{Rails.root}/db/seeds/ceramic.rb"
require "#{Rails.root}/db/seeds/metal.rb"


### Material Specified ###

# ceramic

# metal


# organic
organic_material_specifieds = ["amber", "antler", "bone animal", "bone human", "charcoal", "coral", "hair", "horn"]
organic_material_specifieds.each do |material|
  m = TermlistMaterialSpecified.create name: material
  organic.termlist_material_specifieds << m
end

# stone
stone_material_specifieds = ["flint", "carnelian", "limestone", "basalt", "mabre"]
stone_material_specifieds.each do |material|
  m = TermlistMaterialSpecified.create name: material
  stone.termlist_material_specifieds << m
end
                                    






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


                          
frit_kind_of_objects = ["cylinder seal"]



frit_kind_of_objects.each do |kind|
  TermlistKindOfObject.create name: kind
end
                                              
mill_kind_specifieds = ["manually operated mill", "Olynthus mill"]
sculpture_kind_specifieds = ["bust", "head", "relief", "statue"]
bead_kind_specifieds = ["eye bead"]

specifieds = architectural_element_kind_specifieds + mill_kind_specifieds +
             sculpture_kind_specifieds + vessel_kind_specifieds + bead_kind_specifieds +
             vessel_kind_specifieds
 
#ToDo: This is not the proper way to select the correct entry
vessel = TermlistKindOfObject.where(name: "vessel").first
vessel_kind_specifieds.each do |kind|
  kind_of_object = TermlistKindOfObjectSpecified.create name: kind
  vessel.termlist_kind_of_object_specifieds << kind_of_object
end 
            
          
frit_preservation_states = ["corroded", "iridescent", "bottom", "complete", "complete profile", "foot", 
                            "fragmentary", "handle", "handle-to-wall", "rim", "rim-to-wall", "stem", "wall-to-bottom"]
                            
#frit_preservation_states.each do |state|
#  s = TermlistPreservationState.create name: state
#  frit.termlist_preservation_states << s
#end  

                          


jewelry_blue = TermlistKindOfObject.create name: "jewelry"
egyptian_blue.termlist_kind_of_objects << jewelry_blue

e_vessel = TermlistKindOfObject.create name: "vessel"
egyptian_blue.termlist_kind_of_objects << e_vessel

u_blue = TermlistKindOfObject.create name: "undetermined"
egyptian_blue.termlist_kind_of_objects << u_blue


kind_of_object_jewelry_blues = ["pendant", "undetermined"]
kind_of_object_jewelry_blues.each do |kind|
  s = TermlistKindOfObjectSpecified.create name: kind
  jewelry_blue.termlist_kind_of_object_specifieds << s
end

s = TermlistKindOfObjectSpecified.create name: "undetermined"
e_vessel.termlist_kind_of_object_specifieds << s

mold = TermlistProduction.create name: "mold-made"
undetermined = TermlistProduction.create name: "undetermined"
egyptian_blue.termlist_productions << mold
egyptian_blue.termlist_productions << undetermined

lblue = TermlistColor.create name: "light blue"
dblue = TermlistColor.create name: "dark blue"

egyptian_blue.termlist_colors << lblue
egyptian_blue.termlist_colors << dblue

e_decorations = ["cutting", "drilling", "glazing", "painting", "undetermined"]

e_decorations.each do |deco|
  d = TermlistDecoration.create name: deco
  egyptian_blue.termlist_decorations << d
end

deco_color = TermlistDecorationColor.create name: "none"
egyptian_blue.termlist_decoration_colors << deco_color


###################################




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
