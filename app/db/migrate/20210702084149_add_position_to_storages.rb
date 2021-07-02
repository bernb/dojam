class AddPositionToStorages < ActiveRecord::Migration[6.1]
  def change
    add_column :storages, :position, :integer
  end
end
