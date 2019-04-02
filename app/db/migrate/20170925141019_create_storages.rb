class CreateStorages < ActiveRecord::Migration[5.0]
  def change
    create_table :storages do |t|
      t.string :name
      t.references :museum, foreign_key: true

      t.timestamps
    end
  end
end
