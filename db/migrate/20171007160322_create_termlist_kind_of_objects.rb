class CreateTermlistKindOfObjects < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_kind_of_objects do |t|
      t.string :name

      t.timestamps
    end
  end
end
