class CreateJoinTableMuseumObjectTermlistMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :join_table_museum_object_termlist_materials do |t|
      t.references :museum_object, foreign_key: true
      t.references :termlist_material, foreign_key: true

      t.timestamps
    end
  end
end
