class RemoveIsDatingCenturyEndBcFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :museum_objects, :is_dating_century_end_bc, :boolean
  end
end
