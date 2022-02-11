FactoryBot.define do
  factory :museum do
    sequence(:name) {|n| "museum_#{n}"}
  end

  factory :JAM, class: "Museum" do
    name {"JAM"}
  end
end