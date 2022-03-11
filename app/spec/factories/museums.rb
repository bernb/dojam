FactoryBot.define do
  factory :museum do
    sequence(:name) {|n| "museum_#{n}"}
  end

  factory :JAM, class: "Museum" do
    name {"JAM"}
  end

  factory :JAM_with_storage_locations, class: "Museum" do
    name {"JAM"}
    transient do
      storage_count {3}
    end
    after(:create) do |museum, eval|
      create_list(:storage_with_locations, eval.storage_count, museum: museum)
      museum.reload
    end
  end
end