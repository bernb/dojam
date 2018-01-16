class CreateTermlistKindOfObjectSpecifiedsInscriptionLetters < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_kind_of_object_specifieds_inscription_letters do |t|
      t.references :termlist_kind_of_object_specified, foreign_key: true, index: {name: "index_koos_inscription_letters_on_koos_id"}
      t.references :termlist_inscription_letter, foreign_key: true, index: {name: "index_koos_inscription_letters_on_inscription_letter_id"}

      t.timestamps
    end
  end
end
