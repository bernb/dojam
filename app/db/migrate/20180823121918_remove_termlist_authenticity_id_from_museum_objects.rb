class RemoveTermlistAuthenticityIdFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :museum_objects, :termlist_authenticity_id, :integer
  end
end
