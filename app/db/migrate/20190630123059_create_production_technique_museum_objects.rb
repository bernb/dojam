class CreateProductionTechniqueMuseumObjects < ActiveRecord::Migration[5.2]
  def up
    create_table :production_technique_museum_objects do |t|
      t.references :museum_object, foreign_key: true
      t.references :production_technique, foreign_key: true

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
