class ChangeUsersDropDefaultMuseum < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :museum_id, nil
  end
end
