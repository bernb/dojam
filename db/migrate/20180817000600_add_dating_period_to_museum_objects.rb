class AddDatingPeriodToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		add_column :museum_objects, :dating_period_id, :integer
		add_foreign_key :museum_objects, :termlists, column: :dating_period_id
  end
end
