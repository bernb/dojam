class CreateExcavationSites < ActiveRecord::Migration[5.0]
  def change
    create_table :excavation_sites do |t|
      t.string :name
      t.string :name_mega_jordan
      t.string :name_expedition
      t.integer :site_number_mega
      t.integer :site_number_jadis
      t.integer :site_number_expedition
      t.string :coordinates_mega
      t.references :excavation_site_kind, foreign_key: true

      t.timestamps
    end
  end
end
