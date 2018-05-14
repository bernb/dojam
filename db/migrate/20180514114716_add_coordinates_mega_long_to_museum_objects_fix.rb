class AddCoordinatesMegaLongToMuseumObjectsFix < ActiveRecord::Migration[5.2]
  def change
    add_column :museum_objects, :coordinates_mega_long, :string
  end
end
