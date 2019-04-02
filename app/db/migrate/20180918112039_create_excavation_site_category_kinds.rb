class CreateExcavationSiteCategoryKinds < ActiveRecord::Migration[5.2]
  def change
    create_table :excavation_site_category_kinds do |t|
      t.column :excavation_site_category_id, :integer
      t.column :excavation_site_kind_id, :integer
      t.timestamps
    end
		add_foreign_key :excavation_site_category_kinds, :termlists, column: :excavation_site_category_id
		add_foreign_key :excavation_site_category_kinds, :termlists, column: :excavation_site_kind_id
  end
end
