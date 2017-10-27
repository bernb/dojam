class AddTermlistMaterialSpecifiedToTermlistColors < ActiveRecord::Migration[5.0]
  def change
    add_reference :termlist_colors, :termlist_material_specified, foreign_key: true
  end
end
