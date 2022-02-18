FactoryBot.define do
  sequence(:inv_number) { |n| "T.#{n}"}
  factory :museum_object do
    trait :step_museum_complete do
      inv_number    { generate(:inv_number) }
      storage_location
    end

    factory :mo_at_step_acquisition, traits: [:step_museum_complete]
  end

  #
  # factory :museum_object do
  #   inv_number
  #   storage_location
  #   amount {1}
  #   factory :fully_defined_museum_object do
  #
  #   end
  # end
end
