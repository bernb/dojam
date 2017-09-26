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

storage_locationA = StorageLocation.create name: "Shelf A"
storage_locationB = StorageLocation.create name: "Shelf B"

storage1.storage_locations << storage_location1
storage1.storage_locations << storage_location2

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
