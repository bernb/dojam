class CreateTermlistDecorationTechniques < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_decoration_techniques do |t|
      t.string :name
      t.references :termlist_kind_of_object_specified, foreign_key: true, index: {name: "index_decoration_technique_on_museum_objects"}

      t.timestamps
    end
  end
end
