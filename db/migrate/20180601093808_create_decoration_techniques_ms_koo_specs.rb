class CreateDecorationTechniquesMsKooSpecs < ActiveRecord::Migration[5.2]
  def change
    create_table :decoration_techniques_ms_koo_specs do |t|
      t.references :termlist_decoration_technique, foreign_key: true, index: {name: "index_deco_techs_ms_koo_specs_on_decoration_technique_id"}
      t.references :material_specifieds_koo_spec, foreign_key: true, index: {name: "index_deco_techs_ms_koo_specs_on_ms_koo_spec_id"}


      t.timestamps
    end
  end
end
