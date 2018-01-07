class CreateTermlistPreservationObjects < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_preservation_objects do |t|
      t.string :name
      t.references :termlist_kind_of_object_specified, foreign_key: true, index: {name: "index_preservation_object+_on_kind_of_object"}

      t.timestamps
    end
  end
end
