class CreateDecorationsMsKooSpecs < ActiveRecord::Migration[5.2]
  def change
    create_table :decorations_ms_koo_specs do |t|
      t.references :termlist_decoration, foreign_key: true, index: {name: "index_decorations_ms_koo_specs_on_decoration_id"}
      t.references :material_specifieds_koo_spec, foreign_key: true, index: {name: "index_decorations_ms_koo_specs_on_ms_koo_spec_id"}


      t.timestamps
    end
  end
end
