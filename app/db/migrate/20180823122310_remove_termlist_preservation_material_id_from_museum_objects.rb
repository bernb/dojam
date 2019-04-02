class RemoveTermlistPreservationMaterialIdFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :museum_objects, :termlist_preservation_material_id, :integer
  end
end
