class RemoveAcquisitionKindNameFromMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :museum_objects, :acquisition_kind_name, :string
  end
end
