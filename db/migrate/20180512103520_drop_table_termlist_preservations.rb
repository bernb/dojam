class DropTableTermlistPreservations < ActiveRecord::Migration[5.2]
  def change
    drop_table :termlist_preservations
  end
end
