class CreateDecorationColorsMsKooSpecs < ActiveRecord::Migration[5.2]
  def change
    create_table :decoration_colors_ms_koo_specs do |t|
      t.references :termlist_decoration_color, foreign_key: true, index: {name: "index_deco_colors_ms_koo_specs_on_deco_color_id"}
      t.references :material_specifieds_koo_spec, foreign_key: true, index: {name: "index_deco_colors_ms_koo_specs_on_ms_koo_spec_id"}


      t.timestamps
    end
  end
end
