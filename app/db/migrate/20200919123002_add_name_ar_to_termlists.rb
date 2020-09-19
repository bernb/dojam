class AddNameArToTermlists < ActiveRecord::Migration[6.0]
  def change
    add_column :termlists, :name_ar, :string
  end
end
