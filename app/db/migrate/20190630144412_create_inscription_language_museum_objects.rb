class CreateInscriptionLanguageMuseumObjects < ActiveRecord::Migration[5.2]
  def up
    create_table :inscription_language_museum_objects do |t|
      t.references :museum_object, foreign_key: true
      t.column :inscription_language_id, :integer, index: true, index: {name: :index_inscr_language_m_objects_on_inscr_language_id}
      t.foreign_key :termlists, column: :inscription_language_id

      t.timestamps
    end

    MuseumObject.all.each do |m|
      InscriptionLanguageMuseumObject.create museum_object_id: m.id, inscription_language_id: m.inscription_language.id
    end
  end

  def down 
    drop_table :inscription_language_museum_objects
  end
end
