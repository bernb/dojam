class CreateTermlistConservations < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_conservations do |t|
      t.string :name

      t.timestamps
    end
  end
end
