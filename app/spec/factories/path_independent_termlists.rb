FactoryBot.define do
  factory :authenticity do
    name_en { Faker::Food.unique.vegetables }
  end
end