FactoryBot.define do
  factory :loan_out do
    to_institution { Faker::Name.unique.name }
    borrower_name { Faker::Name.unique.name }
    borrower_job_title { Faker::Name.unique.name }
    date_out { Faker::Date.backward.to_s }
    request_document_number { "MyString" }
    request_document_date { Faker::Date.backward.to_s }
    request_document_signed_by { Faker::Name.unique.name }
    lender_name { Faker::Name.unique.name }
    lender_job_title { Faker::Name.unique.name }
    loan_document_number { Faker::Number.unique.number(digits: 10) }
    return_date { Faker::Date.forward.to_s }
    object_condition { Faker::Name.unique.name }
    museum_object
  end
end
