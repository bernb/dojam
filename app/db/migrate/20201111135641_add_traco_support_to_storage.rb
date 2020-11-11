class AddTracoSupportToStorage < ActiveRecord::Migration[6.0]
  def change
    rename_column :storages, :name, :name_en
    add_column :storages, :name_ar, :string
  end
end
