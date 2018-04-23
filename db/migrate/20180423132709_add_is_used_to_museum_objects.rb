class AddIsUsedToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    add_column :museum_objects, :is_used, :boolean, default: false
  end
end
