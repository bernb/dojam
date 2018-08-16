class CreateMaterialSpecifiedMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    create_table :material_specified_museum_objects do |t|
      t.references :termlist, foreign_key: true, column: :material_specified
      t.references :museum_object, foreign_key: true

      t.timestamps
    end
  end
end
