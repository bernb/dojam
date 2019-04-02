class AddExcavationSiteKindsToExcavationSiteCategory < ActiveRecord::Migration[5.2]
  def change
		add_column :termlists, :excavation_site_kind_id, :integer
		add_foreign_key :termlists, :termlists, column: :excavation_site_kind_id
  end
end
