class RemoveTermlistAcquisitionKindIdFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :museum_objects, :termlist_acquisition_kind_id, :integer
  end
end
