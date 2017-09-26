class AddExcavationSiteToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :museum_objects, :excavation_site, foreign_key: true
  end
end
