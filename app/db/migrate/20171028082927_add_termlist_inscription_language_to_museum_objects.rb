class AddTermlistInscriptionLanguageToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :museum_objects, :termlist_inscription_language, foreign_key: true
  end
end
