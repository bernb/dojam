class AddTermlistProductionTechniqueToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :museum_objects, :termlist_production_techniques, foreign_key: true
  end
end
