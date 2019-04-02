class RemovePriorityFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		remove_column :museum_objects, :priority
  end
end
