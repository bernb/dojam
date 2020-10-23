class AddPdfExportToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :pdf_export, :binary
  end
end
