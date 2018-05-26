class CreateColorsMsKooSpecs < ActiveRecord::Migration[5.2]
  def change
    create_table :colors_ms_koo_specs do |t|
      t.references :termlist_color, foreign_key: true
      t.references :material_specifieds_koo_spec, foreign_key: true

      t.timestamps
    end
  end
end
