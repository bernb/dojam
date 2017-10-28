class RemoveInscriptionLanguageFromMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :museum_objects, :inscription_language, :string
  end
end
