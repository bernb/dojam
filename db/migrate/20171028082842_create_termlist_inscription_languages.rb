class CreateTermlistInscriptionLanguages < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_inscription_languages do |t|
      t.string :name
      t.references :termlist_material_specified, foreign_key: true, index: {name: 'index_inscription_languages_on_material_specified_id'}

      t.timestamps
    end
  end
end
