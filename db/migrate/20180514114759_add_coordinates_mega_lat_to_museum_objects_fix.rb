class AddCoordinatesMegaLatToMuseumObjectsFix < ActiveRecord::Migration[5.2]
  def change
    add_column :museum_objects, :coordinates_mega_lat, :string
  end
end
