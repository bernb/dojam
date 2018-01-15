museum = Museum.where(name: "JAM").first

storages = []

storageA = Storage.create name: "hall A"
storageB = Storage.create name: "hall B"
storageC = Storage.create name: "hall C"
storages << storageA
storages << storageB
storages << storageC


storageA.each do |storage|
  (1..28).each do |n|
  letter = storage.name[-1] # counts backwards the string thus gets the last char
  location = StorageLocation.create name: "showcase " + letter + n.to_s
  storage.storage_locations << location
  end
end

storageB.each do |storage|
  (1..5).each do |n|
  letter = storage.name[-1] # counts backwards the string thus gets the last char
  location = StorageLocation.create name: "showcase " + letter + n.to_s
  storage.storage_locations << location
  end
end

storageA.each do |storage|
  (1..11).each do |n|
  letter = storage.name[-1] # counts backwards the string thus gets the last char
  location = StorageLocation.create name: "showcase " + letter + n.to_s
  storage.storage_locations << location
  end
end


museum.storages << storages

museum.save!
