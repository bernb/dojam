class CreateMuseumObjectPaths < ActiveRecord::Migration[5.2]
  def change
    create_table :museum_object_paths do |t|
      t.references :museum_object, foreign_key: true
      t.references :path, foreign_key: true

      t.timestamps
    end
  end
end
