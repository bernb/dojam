class UndoRenameJoinTableKoosProdTechniqueIdColumnNamesBugfix < ActiveRecord::Migration[5.0]
  def change
    rename_column :termlist_kind_of_object_specifieds_production_techniques, :production_technique_id_on_koos_join_table, :termlist_production_technique_id
  end
end
