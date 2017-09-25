class CreateStorageLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :storage_locations do |t|
      t.string :name
      t.references :storage, foreign_key: true

      t.timestamps
    end
  end
end
