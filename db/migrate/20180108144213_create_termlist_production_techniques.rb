class CreateTermlistProductionTechniques < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_production_techniques do |t|
      t.string :name
      t.references :termlist_kind_of_object_specified, foreign_key: true

      t.timestamps
    end
  end
end
