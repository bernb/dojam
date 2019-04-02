class AddImagesToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_column :museum_objects, :images, :json
  end
end
