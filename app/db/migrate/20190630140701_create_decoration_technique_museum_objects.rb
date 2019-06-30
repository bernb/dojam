class CreateDecorationTechniqueMuseumObjects < ActiveRecord::Migration[5.2]
  def up 
    create_table :decoration_technique_museum_objects do |t|
      t.references :museum_object, foreign_key: true
      t.column :decoration_technique_id, :integer, index: true, index: {name: :index_decoration_tech_m_objects_on_decoration_tech_id}
      t.foreign_key :termlists, column: :decoration_technique_id

      t.timestamps
    end

    MuseumObject.all.each do |m|
      DecorationTechniqueMuseumObject.create museum_object_id: m.id, decoration_technique_id: m.decoration_technique.id
    end
  end

  def down
    drop_table :decoration_techniqe_museum_objects
  end
end
