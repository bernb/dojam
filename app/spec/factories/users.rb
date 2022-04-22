FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password {"password"}
    is_enabled {true}
    museum

    factory :ext_user do
      has_extended_access {true}
    end

    factory :main_admin do
      email {"main_admin@test.com"}
      has_extended_access {true}
      id {1}
    end

    factory :user_without_museum do
      museum { nil }
    end
  end
end
