class RemoveAcquisitionDateFromMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :museum_objects, :acquisition_date, :string
  end
end
