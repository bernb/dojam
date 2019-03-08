FactoryBot.define do
  factory :museum_object do
		inv_number { "T.1234" }
  end

  factory :pathless_museum_object, class: :museum_object do
    inv_number { "T.0000" }
  end
end
