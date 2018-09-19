class RenameExcavationSiteCategoryToExcavationSiteCategoryIdOnMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		rename_column :museum_objects, :excavation_site_category, :excavation_site_category_id
  end
end
