class AddDatingMillenniumBeginToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		add_column :museum_objects, :dating_millennium_begin_id, :integer
		add_foreign_key :museum_objects, :termlists, column: :dating_millennium_begin_id
  end
end
