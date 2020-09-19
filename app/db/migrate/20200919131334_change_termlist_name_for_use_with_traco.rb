class ChangeTermlistNameForUseWithTraco < ActiveRecord::Migration[6.0]
  def change
    rename_column :termlists, :name, :name_en
  end
end
