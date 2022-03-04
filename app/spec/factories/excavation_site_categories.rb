FactoryBot.define do
  factory :excavation_site_category do
    name_en { Faker::Lorem.word }
    factory :excavation_site_category_with_site_kinds do
      transient do
        excavation_kind_count {3}
      end
      after(:create) do |excavation_site_category, eval|
        create_list(:excavation_site_kind,
                    eval.excavation_kind_count,
                    excavation_site_categories: [excavation_site_category])
        excavation_site_category.reload
      end
    end
  end
end