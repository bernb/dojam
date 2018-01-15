class AddIsAcquisitionDateExactToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_column :museum_objects, :is_acquisition_date_exact, :boolean
  end
end
