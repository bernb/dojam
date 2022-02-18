FactoryBot.define do
  sequence(:inv_number) { |n| "T.#{n}"}
  factory :museum_object do
    trait :step_museum_complete do
      inv_number    { generate(:inv_number) }
      storage_location
    end

    factory :mo_at_step_acquisition, traits: [:step_museum_complete]
  end
end
