class AddTermlistExcavationSiteKindToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :museum_objects, :termlist_excavation_site_kind, foreign_key: true
  end
end
