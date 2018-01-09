class CreateTermlistKindOfObjectSpecifiedsDecorations < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_kind_of_object_specifieds_decorations do |t|
      t.references :termlist_kind_of_object_specified, foreign_key: true, index: {name: "index_join_table_on_kind_of_object_specified"}
      t.references :termlist_decoration, foreign_key: true, index: {name: "index_join_table_on_decoration"}

      t.timestamps
    end
  end
end
