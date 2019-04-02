class AddAcquisitionDocumentNumberToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_column :museum_objects, :acquisition_document_number, :string
  end
end
