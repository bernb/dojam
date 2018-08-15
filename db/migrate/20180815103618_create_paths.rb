class CreatePaths < ActiveRecord::Migration[5.2]
  def change
    create_table :paths do |t|
      t.string :path

      t.timestamps
    end
  end
end
