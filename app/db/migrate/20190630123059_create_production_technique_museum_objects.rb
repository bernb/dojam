class CreateProductionTechniqueMuseumObjects < ActiveRecord::Migration[5.2]
  def up
    create_table :production_technique_museum_objects do |t|
      t.references :museum_object, foreign_key: true
      t.column :production_technique_id, :integer, index: true, index: {name: "index_prod_tech_m_objects_on_production_technique_id"}
      t.foreign_key :termlists, column: :production_technique_id

      t.timestamps
    end

    MuseumObject.all.each do |m|
      ProductionTechniqueMuseumObject.create museum_object_id: m.id, production_technique_id: m.production_technique.id
    end
  end

  def down
    drop_table :production_technique_museum_objects
  end
end
