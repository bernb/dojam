class AddPositionToTermlistDatingMillennium < ActiveRecord::Migration[5.2]
  def change
    add_column :termlist_dating_millennia, :position, :integer
  end
end
