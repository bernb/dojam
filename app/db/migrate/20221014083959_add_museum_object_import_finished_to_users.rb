class AddMuseumObjectImportFinishedToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :museum_object_import_finished, :boolean
  end
end
