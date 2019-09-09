class ChangeLoadnDocumentNumberToLoanDocumentNumberOnLoanOuts < ActiveRecord::Migration[5.2]
  def change
    rename_column :loan_outs, :loadn_document_number, :loan_document_number
  end
end
