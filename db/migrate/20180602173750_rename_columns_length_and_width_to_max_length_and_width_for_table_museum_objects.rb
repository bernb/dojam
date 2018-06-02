class RenameColumnsLengthAndWidthToMaxLengthAndWidthForTableMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		rename_column :museum_objects, :remaining_length, :max_length 
		rename_column :museum_objects, :remaining_width, :max_width
		rename_column :museum_objects, :remaining_height, :height
		rename_column :museum_objects, :remaining_opening_dm, :opening_dm
		rename_column :museum_objects, :remaining_bottom_dm, :bottom_dm
		rename_column :museum_objects, :remaining_weight_in_gram, :weight_in_gram
  end
end
