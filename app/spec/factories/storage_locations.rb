FactoryBot.define do
  factory :storage_location do
    sequence(:name_en) {|n| "storage_location_#{n}"}
    storage
  end
end