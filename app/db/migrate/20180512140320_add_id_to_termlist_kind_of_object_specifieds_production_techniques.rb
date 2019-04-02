class AddIdToTermlistKindOfObjectSpecifiedsProductionTechniques < ActiveRecord::Migration[5.2]
  def change
    add_column :termlist_kind_of_object_specifieds_production_techniques, :id, :primary_key
  end
end
