class RemoveTermlistExcavationSiteKindIdFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :museum_objects, :termlist_excavation_site_kind_id, :integer
  end
end
