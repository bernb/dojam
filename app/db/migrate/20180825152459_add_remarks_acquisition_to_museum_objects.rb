class AddRemarksAcquisitionToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    add_column :museum_objects, :remarks_acquisition, :text
  end
end
