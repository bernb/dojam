class AddTermlistDecorationColorToTermlistKindOfObjectSpecifiedsDecorationColors < ActiveRecord::Migration[5.0]
  def change
    add_reference :termlist_kind_of_object_specifieds_decoration_colors, :termlist_decoration_color, foreign_key: true, index: {name: "index_join_table_on_termlist_decoration_color_id"}
  end
end
