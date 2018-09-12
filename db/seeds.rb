Dir["#{Rails.root}/db/data/*.rb"].reject{|file| file.include?("test") || file.include?("general") }.each {|file| require file}
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

Rails.logger.info "*** Starting termlist import ***"
global_variables.select{|var| var.to_s.ends_with? "_material_data"}
								.reject{|var| var.to_s.include? "test"}
								.each do |material_data|
	Rails.logger.info "Importing variable " + material_data.to_s
	# Eval as material_data is given as a symbol
#	material_import eval(material_data.to_s)
end
# import_dating_data
Rails.logger.info "*** Finished termlist import ***"
