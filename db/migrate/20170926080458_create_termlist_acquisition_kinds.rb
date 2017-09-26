class CreateTermlistAcquisitionKinds < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_acquisition_kinds do |t|
      t.string :name

      t.timestamps
    end
  end
end
