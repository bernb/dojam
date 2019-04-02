class AddColumnsToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_column :museum_objects, :remaining_length, :float
    add_column :museum_objects, :remaining_width, :float
    add_column :museum_objects, :remaining_height, :float
    add_column :museum_objects, :remaining_opening_dm, :float
    add_column :museum_objects, :remaining_bottom_dm, :float
    add_column :museum_objects, :remaining_weight_in_gram, :float
  end
end
