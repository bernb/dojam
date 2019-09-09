FactoryBot.define do
  factory :loan_out do
    to_institution { "MyString" }
    borrower_name { "MyString" }
    borrower_job_title { "MyString" }
    date_out { "2019-09-09" }
    request_document_number { "MyString" }
    request_document_date { "2019-09-09" }
    request_document_signed_by { "MyString" }
    lender_name { "MyString" }
    lender_job_title { "MyString" }
    loadn_document_number { "MyString" }
    return_date { "2019-09-09" }
    object_condition { "MyText" }
    museum_object { nil }
  end
end
