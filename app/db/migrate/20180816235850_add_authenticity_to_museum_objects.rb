class AddAuthenticityToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		add_column :museum_objects, :authenticity_id, :integer
		add_foreign_key :museum_objects, :termlists, column: :authenticity_id
  end
end
