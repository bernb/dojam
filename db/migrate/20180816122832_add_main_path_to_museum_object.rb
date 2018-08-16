class AddMainPathToMuseumObject < ActiveRecord::Migration[5.2]
  def change
		add_column :museum_objects, :main_path_id, :integer
		add_foreign_key :museum_objects, :paths, column: :main_path_id
  end
end
