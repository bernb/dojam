class AddPdfExportFinishedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :pdf_export_finished, :boolean, default: false
  end
end
