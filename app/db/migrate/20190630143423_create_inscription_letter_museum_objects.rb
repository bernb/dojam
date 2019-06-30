class CreateInscriptionLetterMuseumObjects < ActiveRecord::Migration[5.2]
  def up
    create_table :inscription_letter_museum_objects do |t|
      t.references :museum_object, foreign_key: true
      t.column :inscription_letter_id, :integer, index: true, index: {name: :index_inscr_letter_m_objects_on_inscr_letter_id}
      t.foreign_key :termlists, column: :inscription_letter_id

      t.timestamps
    end

    MuseumObject.all.each do |m|
      InscriptionLetterMuseumObject.create museum_object_id: m.id, inscription_letter_id: m.inscription_letter.id
    end
  end

  def down 
    drop_table :inscription_letter_museum_objects
  end
end
