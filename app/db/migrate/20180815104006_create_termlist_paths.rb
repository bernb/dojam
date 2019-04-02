class CreateTermlistPaths < ActiveRecord::Migration[5.2]
  def change
    create_table :termlist_paths do |t|
      t.references :termlist, foreign_key: true
      t.references :path, foreign_key: true

      t.timestamps
    end
  end
end
