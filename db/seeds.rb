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

stone = TermlistMaterial.create name: "stone"
metal = TermlistMaterial.create name: "metal"

silver =  TermlistMaterialSpecified.create name: "silver"
gold   =  TermlistMaterialSpecified.create name: "gold"
iron   =  TermlistMaterialSpecified.create name: "iron"
copper   =  TermlistMaterialSpecified.create name: "copper"
lead   =  TermlistMaterialSpecified.create name: "lead"

flint   =  TermlistMaterialSpecified.create name: "flint"
carnelian   =  TermlistMaterialSpecified.create name: "carnelian"
limestone   =  TermlistMaterialSpecified.create name: "limestone"

stone.termlist_material_specifieds << flint
stone.termlist_material_specifieds << carnelian
stone.termlist_material_specifieds << limestone
metal.termlist_material_specifieds << gold
metal.termlist_material_specifieds << silver
metal.termlist_material_specifieds << iron
metal.termlist_material_specifieds << copper
metal.termlist_material_specifieds << lead

TermlistColor.create name: "grey"
TermlistColor.create name: "black"
TermlistColor.create name: "dark red"

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
                      

metal_kind_of_objects = [ "applicator","arrowhead","ax","balance weight","bangle","bead","bell","bracelet","brazier (Kohlenbecken)", 
                          "brooch", "buckle", "button", "candelabra", "cannon", "chain", "chain armor (Kettenhemd)", "coin", 
                          "compasses (Zirkel)", "cosmetic containers", "cosmetic spatula", "cosmetic spoon", "cotter-pin (Splint)" ]
metal_kind_of_objects.each do |kind|
  TermlistKindOfObject.create name: kind
end

# ToDo: Add real entries for specified kind of objects
metal_kind_of_object_specifieds = [ "applicator","arrowhead","ax","balance weight","bangle","bead","bell","bracelet","brazier (Kohlenbecken)", 
                          "brooch", "buckle", "button", "candelabra", "cannon", "chain", "chain armor (Kettenhemd)", "coin", 
                          "compasses (Zirkel)", "cosmetic containers", "cosmetic spatula", "cosmetic spoon", "cotter-pin (Splint)" ]
metal_kind_of_object_specifieds.each do |kind|
  TermlistKindOfObjectSpecified.create name: kind
end

metal_productions = [ "annealing", "beating", "casting in a mould", "casting with lost wax technique", "cutting", "drawing", "forging", "hammering", "repousé", "riveting", "smelting", "soldering"]
metal_productions.each do |production|
  TermlistProduction.create name: production
end

metal_decorations = [ "chasing", "differential alloying", "engraving", "filigree", "gilding", "granulation", "inlay", "niello", "patination", "punching", "stamping", "plated"]

metal_productions.each do |decoration|
  TermlistDecoration.create name: decoration
end
