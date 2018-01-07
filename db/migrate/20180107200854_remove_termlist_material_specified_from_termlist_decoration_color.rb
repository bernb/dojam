class RemoveTermlistMaterialSpecifiedFromTermlistDecorationColor < ActiveRecord::Migration[5.0]
  def change
    remove_reference :termlist_decoration_colors, :termlist_material_specified, foreign_key: true
  end
end
