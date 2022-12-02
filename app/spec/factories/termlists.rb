# ToDo: Never create m/ms/koo/koos without path
FactoryBot.define do
  factory :material, aliases: [:m] do
    name_en { Faker::Lorem.word }
    factory :material_with_ms do
      transient do
        ms_count {3}
      end
      after(:create) do |m, evaluator|
        ms_undetermined = create(:material_specified, name_en: 'undetermined')
        create(:path, path: "/#{m.id}/#{ms_undetermined.id}")
        ms_list = create_list(:material_specified, evaluator.ms_count-1)
        ms_list.each{|ms| create(:path, path: "/#{m.id}/#{ms.id}")}
      end
    end
  end

  factory :material_specified, aliases: [:ms] do
    name_en { Faker::Lorem.word }
    factory :ms_with_material do
      after(:create) do |ms|
        m = create(:material)
        p = create(:path, path: "/#{m.id}/#{ms.id}")
        ms.paths << p
      end
    end
  end

  factory :kind_of_object, aliases: [:koo] do
    name_en { Faker::Lorem.word }
    factory :kind_of_object_with_path, aliases: [:koo_with_path] do
      # Note that a path implies existing m/ms
      after(:create) do |koo|
        ms = create(:ms_with_material)
        path = create(:path, path: "/#{ms.material.id}/#{ms.id}/#{koo.id}")
        koo.paths << path
      end
    end
  end

  factory :kind_of_object_specified, aliases: [:koos] do
    name_en { Faker::Lorem.word }
    factory :kind_of_object_specified_with_path, aliases: [:koos_with_path] do
      # Note that a path implies existing m/ms/koo
      after(:create) do |koos|
        koo = create(:koo_with_path)
        ms = koo.paths.first.parent.last_object
        path = create(:path, path: "/#{ms.material.id}/#{ms.id}/#{koo.id}/#{koos.id}")
        koos.paths << path
      end
    end
  end
end

def create_undetermined_termlist_set
  m = Material.find_or_create_by name_en: 'undetermined'
  ms = MaterialSpecified.find_or_create_by name_en: 'undetermined'
  koo = KindOfObject.find_or_create_by name_en: 'undetermined'
  koos = KindOfObjectSpecified.find_or_create_by name_en: 'undetermined'
  # Material adds its path within a callback so we can not do it here as well
  pathname = "/#{m.id}"
  pathname << "/#{ms.id}"
  path = Path.find_or_create_by path: pathname
  ms.paths << path
  pathname << "/#{koo.id}"
  path = Path.find_or_create_by path: pathname
  koo.paths << path
  pathname << "/#{koos.id}"
  path = Path.find_or_create_by path: pathname
  koos.paths << path
end

def create_minimal_termlist_set
  material_specifieds = FactoryBot.create_list(:ms_with_material, 3)
  material_specifieds.each do |ms|
    m_id = ms.material.id
    koo = FactoryBot.create(:kind_of_object)
    koos = FactoryBot.create(:kind_of_object_specified)
    FactoryBot.create(:path, path: "/#{m_id}/#{ms.id}/#{koo.id}/#{koos.id}")
  end
end