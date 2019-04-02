class AddTermlistKindOfObjectSpecifiedToTermlistDecorationColor < ActiveRecord::Migration[5.0]
  def change
    add_reference :termlist_decoration_colors, :termlist_kind_of_object_specified, foreign_key: true, index: {name: "index_decoration_color_on_kind_of_object_specified"}
  end
end
