class RemoveTermlistAcquisitionDeliveredByIdFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :museum_objects, :termlist_acquisition_delivered_by_id, :integer
  end
end
