class AddTracoSupportToStorageLocations < ActiveRecord::Migration[6.0]
  def change
    rename_column :storage_locations, :name, :name_en
    add_column :storage_locations, :name_ar, :string
  end
end
