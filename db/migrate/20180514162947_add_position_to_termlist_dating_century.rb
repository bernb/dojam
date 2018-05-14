class AddPositionToTermlistDatingCentury < ActiveRecord::Migration[5.2]
  def change
    add_column :termlist_dating_centuries, :position, :integer
  end
end
