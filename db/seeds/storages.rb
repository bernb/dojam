museum = Museum.where(name: "JAM").first

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
