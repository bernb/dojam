class AddDecorationTechniquesToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		add_column :museum_objects, :decoration_technique_id, :integer
		add_foreign_key :museum_objects, :termlists, column: :decoration_technique_id
  end
end
