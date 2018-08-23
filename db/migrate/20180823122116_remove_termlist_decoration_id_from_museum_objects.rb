class RemoveTermlistDecorationIdFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :museum_objects, :termlist_decoration_id, :integer
  end
end
