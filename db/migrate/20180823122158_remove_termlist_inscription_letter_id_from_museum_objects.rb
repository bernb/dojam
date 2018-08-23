class RemoveTermlistInscriptionLetterIdFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :museum_objects, :termlist_inscription_letter_id, :integer
  end
end
