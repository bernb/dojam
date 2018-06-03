class CreateTermlistPriorities < ActiveRecord::Migration[5.2]
  def change
    create_table :termlist_priorities do |t|
      t.string :name

      t.timestamps
    end
  end
end
