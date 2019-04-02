class AddInscriptionLetterToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		add_column :museum_objects, :inscription_letter_id, :integer
		add_foreign_key :museum_objects, :termlists, column: :inscription_letter_id
  end
end
