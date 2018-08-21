class AddDatingCenturyBeginAndEndToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		add_column :museum_objects, :dating_century_begin_id, :integer
		add_foreign_key :museum_objects, :termlists, column: :dating_century_begin_id

		add_column :museum_objects, :dating_century_end_id, :integer
		add_foreign_key :museum_objects, :termlists, column: :dating_century_end_id
  end
end
