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
  end
end
