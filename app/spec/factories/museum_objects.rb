# ToDo: Unify creation of stepwise factories and factories with focus on paths.
# As of now the latter are not valid museum objects due to missing attributes
FactoryBot.define do
  sequence(:inv_number) { |n| "T.#{n}"}
  factory :museum_object do
    trait :step_museum_complete do
      inv_number    { generate(:inv_number) }
      storage_location
    end
    trait :step_acquisition_complete do
      acquisition_delivered_by
      acquisition_kind
    end

    trait :step_provenance_complete do
    end

    trait :step_material_complete do
      after(:create) do |mo|
        material = create(:material_with_ms)
        mo.secondary_paths == [material.path]
        mo.save
      end
    end

    # Stepwise factories
    factory :mo_at_step_acquisition, traits: [
      :step_museum_complete]
    factory :mo_at_step_provenance, traits: [
      :step_museum_complete,
      :step_acquisition_complete]
    factory :mo_at_step_material, traits: [
      :step_museum_complete,
      :step_acquisition_complete,
      :step_provenance_complete]
    factory :mo_at_step_material_specified, traits: [
      :step_museum_complete,
      :step_acquisition_complete,
      :step_provenance_complete,
      :step_material_complete]

    factory :complete_museum_object, traits: [
      :step_museum_complete,
      :step_acquisition_complete,
      :step_provenance_complete,
      :step_material_complete]

    # Factories with focus on paths
    factory :museum_object_with_main_path, aliases: [:mo_with_main] do
      transient do
        koos {create(:koos_with_path)}
      end
      main_path { koos.paths.first }
    end

    factory :museum_object_with_secondary_path_koo, aliases: [:mo_with_secondary_koo] do
      transient do
        koo {create(:koo_with_path)}
      end
      path { koo.paths.first }
    end

    factory :museum_object_without_paths, aliases: [:mo_without_paths]
  end
end
