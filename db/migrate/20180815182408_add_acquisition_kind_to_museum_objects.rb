class AddAcquisitionKindToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		add_column :museum_objects, :acquisition_kind_id, :integer
    add_foreign_key :museum_objects, :termlists, column: :acquisition_kind_id
  end
end
