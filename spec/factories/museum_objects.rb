FactoryBot.define do
  factory :valid_museum_object, class: :museum_object  do
		inv_number { "T.1234" }
    amount { 1 }
    storage_location { StorageLocation.first }
  end

  factory :pathless_museum_object, class: :museum_object do
    inv_number { "T.0000" }
    main_path { nil }
  end
end
