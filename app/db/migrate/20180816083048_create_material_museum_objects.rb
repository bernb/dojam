class CreateMaterialMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    create_table :material_museum_objects do |t|
      t.references :termlist, foreign_key: true
      t.references :museum_object, foreign_key: true

      t.timestamps
    end
  end
end
