class CreateTermlistKindOfObjectSpecifiedsPreservationMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_kind_of_object_specifieds_preservation_materials do |t|
      t.references :termlist_kind_of_object_specified, foreign_key: true, index: {name: "index_join_table_koos_preservation_materials_on_koos_id"}
      t.references :termlist_preservation_material, foreign_key: true, index: {name: "index_join_table_koos_pres_materials_on_pres_material_id"}

      t.timestamps
    end
  end
end
