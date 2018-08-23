class RemoveTermlistDatingMillenniumIdFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :museum_objects, :termlist_dating_millennium_id, :integer
  end
end
