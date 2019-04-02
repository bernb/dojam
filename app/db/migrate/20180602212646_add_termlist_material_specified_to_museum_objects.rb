class AddTermlistMaterialSpecifiedToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :museum_objects, :termlist_material_specified, foreign_key: true
  end
end
