class AddReturnAttributesToLoanOuts < ActiveRecord::Migration[5.2]
  def change
    add_column :loan_outs, :planned_return, :date
    add_column :loan_outs, :return_condition, :text
    add_column :loan_outs, :return_remarks, :text
    add_column :loan_outs, :return_document_number, :string
    add_column :loan_outs, :return_document_signed_by, :string
  end
end
