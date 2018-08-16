class AddKindOfObjectToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		add_column :museum_objects, :kind_of_object_id, :integer
		add_foreign_key :museum_objects, :termlists, column: :kind_of_object_id
  end
end
