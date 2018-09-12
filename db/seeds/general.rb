Dir["#{Rails.root}/db/data/general_terms/*.rb"].reject{|file| file.include?("test")}.each {|file| require file}

# *** Import museum and storage data ***
$museum_storage_data.keys.each do |museum_name|
	data = $museum_storage_data[museum_name]
	museum = Museum.find_or_create_by name: museum_name
	museum.prefix = data[:prefix]
	data[:storages].keys.each do |storage_name|
		storage =	Storage.find_or_create_by name: storage_name, museum_id: museum.id
		museum.storages << storage
		data[:storages][storage_name].each do |storage_location_name|
			storage_location = StorageLocation.find_or_create_by name: storage_location_name, storage_id: storage.id
			storage.storage_locations << storage_location
		end # storage locations
		storage.save!
	end # storages
	museum.save!
end

# *** Import general termlists
$general_terms_data.keys.each do |termlist_name|
	classname = termlist_name.to_s.singularize.camelize.constantize
	$general_terms_data[termlist_name].each do |name|
		classname.find_or_create_by name: name
	end
end

$site_kinds.each do |category_name, kinds_array|
  category = ExcavationSiteCategory.find_or_create_by name: category_name
  kinds_array.each do |site_kind_name|
    site_kind = ExcavationSiteKind.find_or_create_by name: site_kind_name
    category.excavation_site_kinds << site_kind
  end
end
