museum = Museum.where(name: "JAM").first

storages = []

storageA = Storage.create name: "hall A"
storageB = Storage.create name: "hall B"
storageC = Storage.create name: "hall C"
storages << storageA
storages << storageB
storages << storageC


(1..28).each do |n|
  letter = storageA.name[-1] # counts backwards the string thus gets the last char
  location = StorageLocation.create name: "showcase " + letter + n.to_s
  storageA.storage_locations << location
end


(1..5).each do |n|
  letter = storageB.name[-1] # counts backwards the string thus gets the last char
  location = StorageLocation.create name: "showcase " + letter + n.to_s
  storageB.storage_locations << location
end

(1..11).each do |n|
  letter = storageC.name[-1] # counts backwards the string thus gets the last char
  location = StorageLocation.create name: "showcase " + letter + n.to_s
  storageC.storage_locations << location
end


museum.storages << storages

museum.save!
