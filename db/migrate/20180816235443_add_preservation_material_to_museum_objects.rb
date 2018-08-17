class AddPreservationMaterialToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		add_column :museum_objects, :preservation_material_id, :integer
		add_foreign_key :museum_objects, :termlists, column: :preservation_material_id
  end
end
