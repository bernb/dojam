class CreateMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    create_table :museum_objects do |t|
      t.integer :inv_number
      t.integer :inv_extension
      t.string :inv_numberdoa
      t.integer :amount
      t.string :finding_context
      t.text :finding_remarks
      t.string :description_authenticities_name
      t.string :description_conservation
      t.string :description_preservation_state_name
      t.string :acquisition_delivered_by
      t.string :acquisition_kind_name
      t.string :acquisition_deliverer_name
      t.string :acquisition_date
      t.references :ex_site, foreign_key: true
      t.references :storage_location, foreign_key: true

      t.timestamps
    end
  end
end
