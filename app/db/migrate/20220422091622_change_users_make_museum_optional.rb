class ChangeUsersMakeMuseumOptional < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :museum_id, true
  end
end
