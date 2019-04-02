class AddAcquisitionYearToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    add_column :museum_objects, :acquisition_year, :integer
  end
end
