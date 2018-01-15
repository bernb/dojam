class AddTermlistExcavationSiteCategoryToTermlistExcavationSiteKinds < ActiveRecord::Migration[5.0]
  def change
    add_reference :termlist_excavation_site_kinds, :termlist_excavation_site_category, foreign_key: true, index: {name: "index_ex_site_kinds_on_ex_site_category_id"}
  end
end
