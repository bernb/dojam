class AddMaxDmToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    add_column :museum_objects, :max_dm, :float
  end
end
