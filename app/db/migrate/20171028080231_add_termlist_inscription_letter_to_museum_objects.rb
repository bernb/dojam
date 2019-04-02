class AddTermlistInscriptionLetterToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :museum_objects, :termlist_inscription_letter, foreign_key: true
  end
end
