FactoryBot.define do
  factory :storage do
    transient do
      storage_location_count {3}
    end
    sequence(:name_en) {|n| "storage_#{n}"}
    museum
    after(:build) do |storage|
      storage.storage_locations << build(:storage_location, storage: storage)
    end
    # storage_locations do
    #   Array.new(storage_location_count) {association(:storage_location)}
    # end
  end
end