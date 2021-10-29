FactoryBot.define do
  factory :material, aliases: :m do
    sequence(:name_en) {|n| "m_#{n}"}
  end

  factory :material_specified, aliases: :ms do
    sequence(:name_en) {|n| "ms_#{n}"}
  end

  factory :kind_of_object, aliases: :koo do
    sequence(:name_en) {|n| "koo_#{n}"}
  end

  factory :kind_of_object_specified, aliases: :koos do
    sequence(:name_en) {|n| "koos_#{n}"}
  end
end