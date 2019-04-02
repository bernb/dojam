class AddTermlistDecorationColorToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :museum_objects, :termlist_decoration_color, foreign_key: true
  end
end
