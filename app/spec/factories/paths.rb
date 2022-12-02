FactoryBot.define do
  factory :path do
    factory :path_from_ms do
      transient do
        m  { create(:m)  }
        ms { create(:ms) }
      end
      path { "/#{m.id}/#{ms.id}" }
    end
  end
end