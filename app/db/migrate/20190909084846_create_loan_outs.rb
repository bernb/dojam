class CreateLoanOuts < ActiveRecord::Migration[5.2]
  def change
    create_table :loan_outs do |t|
      t.string :to_institution
      t.string :borrower_name
      t.string :borrower_job_title
      t.date :date_out
      t.string :request_document_number
      t.date :request_document_date
      t.string :request_document_signed_by
      t.string :lender_name
      t.string :lender_job_title
      t.string :loadn_document_number
      t.date :return_date
      t.text :object_condition
      t.references :museum_object, foreign_key: true

      t.timestamps
    end
  end
end
