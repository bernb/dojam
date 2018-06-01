class CreatePreservationMaterialsMsKooSpecs < ActiveRecord::Migration[5.2]
  def change
    create_table :preservation_materials_ms_koo_specs do |t|
      t.references :termlist_preservation_material, foreign_key: true, index: {name: "index_preservation_m_ms_koo_specs_on_preservation_m_id"}
      t.references :material_specifieds_koo_spec, foreign_key: true, index: {name: "index_preservation_m_ms_koo_specs_on_ms_koo_specs_id"}


      t.timestamps
    end
  end
end
