class AddRemarksToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_column :museum_objects, :remarks, :text
  end
end
