class AddMunsellColorToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    add_column :museum_objects, :munsell_color, :string
  end
end
