class RemoveAcquisitionDeliveredByFromMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :museum_objects, :acquisition_delivered_by, :string
  end
end
