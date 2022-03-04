FactoryBot.define do
  factory :material, aliases: [:m] do
    name_en { Faker::Lorem.word }
  end

  factory :material_specified, aliases: [:ms] do
    name_en { Faker::Lorem.word }
  end

  factory :kind_of_object, aliases: [:koo] do
    name_en { Faker::Lorem.word }
  end

  factory :kind_of_object_specified, aliases: [:koos] do
    name_en { Faker::Lorem.word }
  end
end