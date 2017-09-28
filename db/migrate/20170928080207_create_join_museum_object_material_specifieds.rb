class CreateJoinMuseumObjectMaterialSpecifieds < ActiveRecord::Migration[5.0]
  def change
    create_table :join_museum_object_material_specifieds do |t|
      t.references :museum_object, foreign_key: true, index: {name: 'index_join_museum_object'}
      t.references :termlist_material_specified, foreign_key: true, index: {name: 'index_join_material_specified'}

      t.timestamps
    end
  end
end
