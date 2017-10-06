# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

museum = Museum.create name: "JAM", prefix: "J"
storage1 = Storage.create name: "exhibition"
storage2 = Storage.create name: "storage"

storage_location1 = StorageLocation.create name: "Shelf 1" 
storage_location2 = StorageLocation.create name: "Shelf 2"
storage_location3 = StorageLocation.create name: "Shelf 3"
storage_location4 = StorageLocation.create name: "Shelf 4"
storage_location5 = StorageLocation.create name: "Shelf 5"

storage_locationA = StorageLocation.create name: "Shelf A"
storage_locationB = StorageLocation.create name: "Shelf B"

storage1.storage_locations << storage_location1
storage1.storage_locations << storage_location2
storage1.storage_locations << storage_location3
storage1.storage_locations << storage_location4
storage1.storage_locations << storage_location5

storage2.storage_locations << storage_locationA
storage2.storage_locations << storage_locationB

museum.storages << storage1
museum.storages << storage2

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
