class CreateInscriptionLettersMsKooSpecs < ActiveRecord::Migration[5.2]
  def change
    create_table :inscription_letters_ms_koo_specs do |t|
      t.references :termlist_inscription_letter, foreign_key: true, index: {name: "index_inscription_letters_ms_koo_specs_on_inscription_letter_id"}
      t.references :material_specifieds_koo_spec, foreign_key: true, index: {name: "index_inscription_letters_ms_koo_specs_on_ms_koo_spec_id"}


      t.timestamps
    end
  end
end
