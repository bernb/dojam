class CreateTermlistKindOfObjectSpecifiedsDecorationColors < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_kind_of_object_specifieds_decoration_colors do |t|
      t.references :termlist_kind_of_object_specified, foreign_key: true, index: {name: "index_join_table_on_kind_of_object_spec_id"}
      t.references :termlist_deco_color, foreign_key: true, index: {name: "index_join_table_on_decoration_color_id"}

      t.timestamps
    end
  end
end
