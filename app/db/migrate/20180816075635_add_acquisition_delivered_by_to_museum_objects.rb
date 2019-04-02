class AddAcquisitionDeliveredByToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		add_column :museum_objects, :acquisition_delivered_by_id, :integer
		add_foreign_key :museum_objects, :termlists, column: :acquisition_delivered_by_id
  end
end
