class CreateTermlistPreservationStates < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_preservation_states do |t|
      t.string :name
      t.references :termlist_material, foreign_key: true

      t.timestamps
    end
  end
end
