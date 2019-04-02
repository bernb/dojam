class AddInscriptionLanguageToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		add_column :museum_objects, :inscription_language_id, :integer
		add_foreign_key :museum_objects, :termlists, column: :inscription_language_id
  end
end
