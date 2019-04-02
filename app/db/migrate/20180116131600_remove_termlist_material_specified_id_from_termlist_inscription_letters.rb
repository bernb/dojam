class RemoveTermlistMaterialSpecifiedIdFromTermlistInscriptionLetters < ActiveRecord::Migration[5.0]
  def change
  remove_column :termlist_inscription_letters, :termlist_material_specified_id, foreign_key: true
  end
end
