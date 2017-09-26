class AddTermlistAcquisitionDeliveredByToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :museum_objects, :termlist_acquisition_delivered_by, foreign_key: true
  end
end
