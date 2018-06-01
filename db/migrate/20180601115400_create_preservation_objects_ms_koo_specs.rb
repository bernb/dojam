class CreatePreservationObjectsMsKooSpecs < ActiveRecord::Migration[5.2]
  def change
    create_table :preservation_objects_ms_koo_specs do |t|
      t.references :termlist_preservation_object, foreign_key: true, index: {name: "index_pres_objects_ms_koo_specs_on_pres_object_id"}
      t.references :material_specifieds_koo_spec, foreign_key: true, index: {name: "index_pres_objects_ms_koo_specs_ms_koo_specs_id"}


      t.timestamps
    end
  end
end
