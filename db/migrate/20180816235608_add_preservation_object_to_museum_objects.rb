class AddPreservationObjectToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		add_column :museum_objects, :preservation_object_id, :integer
		add_foreign_key :museum_objects, :termlists, column: :preservation_object_id
  end
end
