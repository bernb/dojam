class RemoveTermlistDatingPeriodIdFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :museum_objects, :termlist_dating_period_id, :integer
  end
end
