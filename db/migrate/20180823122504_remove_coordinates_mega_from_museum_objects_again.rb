class RemoveCoordinatesMegaFromMuseumObjectsAgain < ActiveRecord::Migration[5.2]
  def change
    remove_column :museum_objects, :coordinates_mega, :string
  end
end
