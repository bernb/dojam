class AddAcquisitionDateToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_column :museum_objects, :acquisition_date, :date
  end
end
