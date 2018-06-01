class CreateDatingCenturiesMsKooSpecs < ActiveRecord::Migration[5.2]
  def change
    create_table :dating_centuries_ms_koo_specs do |t|
      t.references :termlist_dating_century, foreign_key: true, index: {name: "index_dating_centuries_ms_koo_specs_on_dating_century_id"}
      t.references :material_specifieds_koo_spec, foreign_key: true, index: {name: "index_dating_centuries_ms_koo_specs_on_ms_koo_spec_id"}

      t.timestamps
    end
  end
end
