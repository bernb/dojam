class CreateMuseumObjectImageLists < ActiveRecord::Migration[5.2]
  def change
    create_table :museum_object_image_lists do |t|
      t.references :museum_object, foreign_key: true

      t.timestamps
    end
  end
end
