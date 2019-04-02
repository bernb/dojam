class RemoveTermlistProductionTechniqueIdFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :museum_objects, :termlist_production_technique_id, :integer
  end
end
