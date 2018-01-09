class CreateTermlistProductionTechniquesTermlistKindOfObjectSpecifiedsJoinTableCorrection < ActiveRecord::Migration[5.0]
  def change
    create_join_table :termlist_production_techniques, :termlist_kind_of_object_specifieds do |t|
      # t.index [:termlist_production_technique_id, :termlist_kind_of_object_specified_id]
      # t.index [:termlist_kind_of_object_specified_id, :termlist_production_technique_id]
    end
  end
end
