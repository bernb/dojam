class AddIndicesToKindOfObjectSpecifiedsProductionTechniques < ActiveRecord::Migration[5.2]
  def change
    add_index :termlist_kind_of_object_specifieds_production_techniques, :termlist_production_technique_id, name: 'index_koos_production_techniques_on_production_technique_id'
    add_index :termlist_kind_of_object_specifieds_production_techniques, :termlist_kind_of_object_specified_id, name: 'index_koos_on_production_technique_id'
  end
end
