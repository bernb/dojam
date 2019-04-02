class RemoveExcavationSiteKindIdFromMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :museum_objects, :excavation_site_kind_id
  end
end
