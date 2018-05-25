class CreateColorsKooSpecs < ActiveRecord::Migration[5.2]
  def change
    create_table :colors_koo_specs do |t|
      t.references :termlist_color, foreign_key: true
      t.references :termlist_kind_of_object_specified, foreign_key: true

      t.timestamps
    end
  end
end
