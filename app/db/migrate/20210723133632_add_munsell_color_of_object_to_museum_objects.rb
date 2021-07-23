class AddMunsellColorOfObjectToMuseumObjects < ActiveRecord::Migration[6.1]
  def change
    add_column :museum_objects, :munsell_color_of_object, :string
  end
end
