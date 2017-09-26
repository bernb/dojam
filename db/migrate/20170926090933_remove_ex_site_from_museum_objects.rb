class RemoveExSiteFromMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    remove_reference :museum_objects, :ex_site, foreign_key: true
  end
end
