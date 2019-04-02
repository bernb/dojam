class RemoveExcavationSiteCategoryIdFromTermlists < ActiveRecord::Migration[5.2]
  def change
    remove_column :termlists, :excavation_site_category_id
  end
end
