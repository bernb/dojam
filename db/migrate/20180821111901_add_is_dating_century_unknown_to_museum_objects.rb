class AddIsDatingCenturyUnknownToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    add_column :museum_objects, :is_dating_century_unknown, :boolean
  end
end
