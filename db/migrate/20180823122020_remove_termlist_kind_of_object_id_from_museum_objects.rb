class RemoveTermlistKindOfObjectIdFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :museum_objects, :termlist_kind_of_object_id, :integer
  end
end
