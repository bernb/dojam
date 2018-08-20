class AddIsDatingCenturyBeginBcToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    add_column :museum_objects, :is_dating_century_begin_bc, :boolean
  end
end
