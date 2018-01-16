class CreateTermlistKindOfObjectSpecifiedsInscriptionLanguages < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_kind_of_object_specifieds_inscription_languages do |t|
      t.references :termlist_kind_of_object_specified, foreign_key: true, index: {name: "index_koos_inscription_languages_on_koos_id"}
      t.references :termlist_inscription_language, foreign_key: true, index: {name: "index_koos_inscription_languages_on_inscription_language_id"}

      t.timestamps
    end
  end
end
