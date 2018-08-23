class RemoveTermlistMaterialSpecifiedIdFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :museum_objects, :termlist_material_specified_id, :integer
  end
end
