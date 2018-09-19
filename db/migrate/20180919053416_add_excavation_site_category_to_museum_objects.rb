class AddExcavationSiteCategoryToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    add_column :museum_objects, :excavation_site_category, :integer
		add_foreign_key :museum_objects, :termlists, column: :excavation_site_category
  end
end
