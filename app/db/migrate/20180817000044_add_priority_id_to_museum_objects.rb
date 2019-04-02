class AddPriorityIdToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		add_column :museum_objects, :priority_id, :integer
		add_foreign_key :museum_objects, :termlists, column: :priority_id
  end
end
