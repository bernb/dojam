# Note that we do a little bit of pre-optimization by avoiding to
# hit the database too often and work with ids instead of the actual objects

@storage_ids = Storage.all.ids
@storage_location_ids = StorageLocation.all.ids

termlist_acquisition_ids = TermlistAcquisitionKind.all.ids

def rand_char
  ('A'..'Z').to_a.sample
end

def rand_storage_id
  @storage_ids.sample
end

def rand_storage_location_id storage_id
  storage = Storage.find storage_id
  storage.storage_locations.ids.sample
end

def rand_storage_location_id
  @storage_location_ids.sample
end

def rand_inv_number prefix
 prefix + "." + rand(100..10000).to_s
end

def rand_other_inv_number
  rand_char + "." + rand_char + rand(100..10000).to_s
end

# Testing with millions of records is on the roadmap so we
# choose a way that allows us to create many records fast by writing
# associations manually into the database instead of doing millions of
# rails calls by using <<.
# For this we need the id of the object beforehand, so we start by creating
# the object.
museum_object = MuseumObject.new
museum_object.save validate: false
museum_object.inv_number = rand_inv_number "J"
museum_object.inv_numberdoa = rand_other_inv_number
museum_object.storage_location = StorageLocation.find rand_storage_location_id
museum_object.inv_extension = rand(15)
museum_object.amount = rand(10)


