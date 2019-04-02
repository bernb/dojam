class CreateTermlists < ActiveRecord::Migration[5.2]
  def change
    create_table :termlists do |t|
      t.string :type
      t.string :name

      t.timestamps
    end
  end
end
