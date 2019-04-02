class AddPositionToTermlistDatingPeriod < ActiveRecord::Migration[5.2]
  def change
    add_column :termlist_dating_periods, :position, :integer
  end
end
