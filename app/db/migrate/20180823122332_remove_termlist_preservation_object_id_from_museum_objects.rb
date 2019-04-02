class RemoveTermlistPreservationObjectIdFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :museum_objects, :termlist_preservation_object_id, :integer
  end
end
