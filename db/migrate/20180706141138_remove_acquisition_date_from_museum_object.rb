class RemoveAcquisitionDateFromMuseumObject < ActiveRecord::Migration[5.2]
  def change
		remove_column :museum_objects, :acquisition_date
  end
end
