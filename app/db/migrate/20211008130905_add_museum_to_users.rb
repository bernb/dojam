class AddMuseumToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :museum, null: false, foreign_key: true, default: 1
  end
end
