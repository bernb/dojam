class AddExtendedAccesToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :has_extended_access, :boolean, default: false
  end
end
