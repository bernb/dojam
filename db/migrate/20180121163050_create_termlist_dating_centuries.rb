class CreateTermlistDatingCenturies < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_dating_centuries do |t|
      t.string :name

      t.timestamps
    end
  end
end
