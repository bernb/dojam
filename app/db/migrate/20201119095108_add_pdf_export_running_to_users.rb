class AddPdfExportRunningToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :pdf_export_running, :boolean, default: false
  end
end
