module StaticPagesHelper
  def self.import_museum_data data
    museum_name = data["museum"]
    if museum_name != "JAM"
      flash[:danger] = "Data for JAM museum can be imported only"
      return
    end
    museum = Museum.find_by name: museum_name
    museum_storage_names = museum.storages.map{|s| s.name}
    data["storages"].each do |storage_hash|
      storage_name = storage_hash.keys.first
      if museum_storage_names.include?(storage_name)
        storage = museum.storages.find_by name_en: storage_name
      else
        storage = Storage.create name_en: storage_name, museum: museum
      end
      storage_hash[storage_name].each do |storage_location_name|
        if storage.storage_locations.map{|sl| sl.name}.include?(storage_location_name)
          next
        else
          storage_location = StorageLocation.create name_en: storage_location_name, storage: storage
        end
      end
    end
  end

  def import_site_names data
    data["site_name"].each do |site_name|
      ExcavationSite.find_or_create_by name: site_name
    end
  end
end
