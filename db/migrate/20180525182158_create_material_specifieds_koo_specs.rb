class CreateMaterialSpecifiedsKooSpecs < ActiveRecord::Migration[5.2]
  def change
    create_table :material_specifieds_koo_specs do |t|
      t.references :termlist_material_specified, foreign_key: true, index: {name: "index_material_specifieds_koo_specs_on_material_specified_id"}
      t.references :termlist_kind_of_object_specified, foreign_key: true, index: {name: "index_material_specifieds_koo_specs_on_koos_id"}

      t.timestamps
    end
  end
end
