class AddExcavationSiteKindToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		add_column :museum_objects, :excavation_site_kind_id, :integer
		add_foreign_key :museum_objects, :termlists, column: :excavation_site_kind_id
  end
end
