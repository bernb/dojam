class CreateTermlistKindOfObjectSpecifiedsDecorationTechniques < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_kind_of_object_specifieds_decoration_techniques do |t|
      t.references :termlist_kind_of_object_specified, foreign_key: true, index: {name: "index_join_table_on_termlist_kind_of_object_specified_id"}
      t.references :termlist_decoration_technique, foreign_key: true, index: {name: "index_join_table_on_termlist_decoration_technique_id"}

      t.timestamps
    end
  end
end
