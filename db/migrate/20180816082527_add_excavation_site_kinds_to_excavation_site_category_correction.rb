class AddExcavationSiteKindsToExcavationSiteCategoryCorrection < ActiveRecord::Migration[5.2]
  def change
		add_column :termlists, :excavation_site_category_id, :integer
		add_foreign_key :termlists, :termlists, column: :excavation_site_category_id
  end
end
