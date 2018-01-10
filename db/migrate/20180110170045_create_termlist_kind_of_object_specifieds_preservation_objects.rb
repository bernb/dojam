class CreateTermlistKindOfObjectSpecifiedsPreservationObjects < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_kind_of_object_specifieds_preservation_objects do |t|
      t.references :termlist_kind_of_object_specified, foreign_key: true, index: {name: "index_koos_preservation_objects_on_koos_id"}
      t.references :termlist_preservation_object, foreign_key: true, index: {name: "index_koos_preservation_objects_on_preservation_material_id"}

      t.timestamps
    end
  end
end
