class RemoveInscriptionLettersFromMuseumObject < ActiveRecord::Migration[5.0]
  def change
    remove_column :museum_objects, :inscription_letters, :string
  end
end
