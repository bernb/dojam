class RemoveTermlistPriorityIdFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :museum_objects, :termlist_priority_id, :integer
  end
end
