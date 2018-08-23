class AddDescriptionToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    add_column :museum_objects, :description, :text
  end
end
