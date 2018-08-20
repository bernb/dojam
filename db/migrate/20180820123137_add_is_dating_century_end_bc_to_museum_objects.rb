class AddIsDatingCenturyEndBcToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    add_column :museum_objects, :is_dating_century_end_bc, :boolean
  end
end
