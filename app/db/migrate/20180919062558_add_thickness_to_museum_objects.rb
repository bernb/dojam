class AddThicknessToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    add_column :museum_objects, :thickness, :float
  end
end
