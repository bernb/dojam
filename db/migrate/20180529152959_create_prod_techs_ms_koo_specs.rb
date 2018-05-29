class CreateProdTechsMsKooSpecs < ActiveRecord::Migration[5.2]
  def change
    create_table :prod_techs_ms_koo_specs do |t|
      t.references :termlist_production_technique, foreign_key: true, index: {name: "index_prod_techs_ms_koo_specs_on_prod_tech_id"}
      t.references :material_specifieds_koo_spec, foreign_key: true, index: {name: "index_prod_techs_ms_koo_specs_on_ms_koo_spec_id"}

      t.timestamps
    end
  end
end
