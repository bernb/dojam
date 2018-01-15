require "#{Rails.root}/db/seeds/seed_helper.rb"


# We seperate data from actual creating
# data files are supposed to return two arrays named:
# materialname_material_specifieds and materialname_kind_of_objects
require "#{Rails.root}/db/seeds/data_material.rb"
require "#{Rails.root}/db/seeds/data_test.rb"

#SeedHelper.build_material_related_seed $test_data
SeedHelper.build_material_related_seed $metal_data
SeedHelper.build_material_related_seed $organic_data
SeedHelper.build_material_related_seed $stone_data
SeedHelper.build_material_related_seed $vitreous_data

=begin 

museum = Museum.create name: "JAM", prefix: "J"

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

TermlistAuthenticity.create name: "archaeological object"
TermlistAuthenticity.create name: "copy"
TermlistAuthenticity.create name: "forgery"
TermlistAuthenticity.create name: "unspecific"
TermlistAuthenticity.create name: "unknown"

ceramic = TermlistMaterial.create name: "ceramic"
metal = TermlistMaterial.create name: "metal"
organic = TermlistMaterial.create name: "organic material"
stone = TermlistMaterial.create name: "stone"
vitreous = TermlistMaterial.create name: "vitreous material"


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
 
 
require "#{Rails.root}/db/seeds/storages.rb"
 
 
=begin                    
                      
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

                          
frit_kind_of_objects = ["cylinder seal"]



frit_kind_of_objects.each do |kind|
  TermlistKindOfObject.create name: kind
end
                                              
mill_kind_specifieds = ["manually operated mill", "Olynthus mill"]
sculpture_kind_specifieds = ["bust", "head", "relief", "statue"]
bead_kind_specifieds = ["eye bead"]
 
            
          
frit_preservation_states = ["corroded", "iridescent", "bottom", "complete", "complete profile", "foot", 
                            "fragmentary", "handle", "handle-to-wall", "rim", "rim-to-wall", "stem", "wall-to-bottom"]
                            
#frit_preservation_states.each do |state|
#  s = TermlistPreservationState.create name: state
#  frit.termlist_preservation_states << s
#end  

                          
=begin

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

=end
