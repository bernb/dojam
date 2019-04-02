class AddTermlistAcquisitionKindToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :museum_objects, :termlist_acquisition_kind, foreign_key: true
  end
end
