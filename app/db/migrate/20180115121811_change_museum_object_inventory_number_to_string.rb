class ChangeMuseumObjectInventoryNumberToString < ActiveRecord::Migration[5.0]
  def change
    change_column :museum_objects, :inv_number, :string
  end
end
