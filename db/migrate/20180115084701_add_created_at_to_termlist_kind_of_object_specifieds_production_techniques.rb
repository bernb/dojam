class AddCreatedAtToTermlistKindOfObjectSpecifiedsProductionTechniques < ActiveRecord::Migration[5.0]
  def change
    add_column :termlist_kind_of_object_specifieds_production_techniques, :created_at, :datetime, null: false
  end
end
