class AddPriorityToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_column :museum_objects, :priority, :integer
  end
end
