FactoryBot.define do
  factory :storage do
    sequence(:name_en) {|n| "storage_#{n}"}
    museum factory: :JAM

    factory :storage_with_locations do
      transient do
        storage_location_count {3}
      end

      after(:create) do |storage, eval|
        create_list(:storage_location, eval.storage_location_count, storage: storage)
        storage.reload
      end
    end
  end
end