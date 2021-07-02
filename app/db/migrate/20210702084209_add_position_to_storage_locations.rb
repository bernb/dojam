class AddPositionToStorageLocations < ActiveRecord::Migration[6.1]
  def change
    add_column :storage_locations, :position, :integer
  end
end
