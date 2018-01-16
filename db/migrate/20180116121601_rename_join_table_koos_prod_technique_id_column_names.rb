class RenameJoinTableKoosProdTechniqueIdColumnNames < ActiveRecord::Migration[5.0]
  def change
    rename_column :termlist_kind_of_object_specifieds_production_techniques, :termlist_production_technique_id, :production_technique_id_on_koos_join_table
  end
end
