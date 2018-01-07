class CreateTermlistPreservationMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_preservation_materials do |t|
      t.string :name
      t.references :termlist_kind_of_object_specified, foreign_key: true, index: {name: "preservation_materials_on_kind_of_object_specified"}

      t.timestamps
    end
  end
end
