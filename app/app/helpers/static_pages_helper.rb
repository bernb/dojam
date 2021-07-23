module StaticPagesHelper
  def self.import_museum_data data
    museum_name = data["museum"]
    if museum_name != "JAM"
      flash[:danger] = "Data for JAM museum can be imported only"
      return
    end
    museum = Museum.find_by name: museum_name
    data["storages"].each.with_index(1) do |storage_hash, index|
      storage_name = storage_hash.keys.first
      storage = museum.storages
                      .find_or_create_by(name_en: storage_name)
      storage.update(position: index)
      storage_hash[storage_name].each.with_index(1) do |location_name, index|
        location = StorageLocation.find_or_create_by(name_en: location_name,
                                                     storage: storage)
        location.update(position: index)
      end
    end
  end

  def self.import_site_names data
    data["site_name"].each do |site_name|
      ExcavationSite.find_or_create_by name: site_name
    end
  end
end
