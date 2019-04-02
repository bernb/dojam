class RemoveIsAcquisitionDateExactFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :museum_objects, :is_acquisition_date_exact, :boolean
  end
end
