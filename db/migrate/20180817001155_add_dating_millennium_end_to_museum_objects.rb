class AddDatingMillenniumEndToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		add_column :museum_objects, :dating_millennium_end_id, :integer
		add_foreign_key :museum_objects, :termlists, column: :dating_millennium_end_id
  end
end
