class RemoveTermlistProductionTechniquesIdFromMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :museum_objects, :termlist_production_techniques_id, foreign_key: true
  end
end
