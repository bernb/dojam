class AddInscriptionColumnsToMuseumObject < ActiveRecord::Migration[5.0]
  def change
    add_column :museum_objects, :inscription_decoration, :string
    add_column :museum_objects, :inscription_letters, :string
    add_column :museum_objects, :inscription_language, :string
    add_column :museum_objects, :inscription_text, :string
    add_column :museum_objects, :inscription_translation, :string
  end
end
