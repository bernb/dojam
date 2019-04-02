class AddAcquisitionDatePrecisionToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    add_column :museum_objects, :acquisition_date_precision, :integer
  end
end
