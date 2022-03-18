require 'rails_helper'

feature 'Add a new object' do
  feature 'step_material_specified', type: :system, js: true do
    let!(:museum_object)            { create :mo_at_step_material_specified}
    let(:material_checkboxes)             { '.museum_object_secondary_path_ids'}

    # ToDo: Let museum object have a material that is not undetermined and create correct ms for it,
    # so that we can check that other ms are not selected
    scenario 'form has correct default values' do
      create_undetermined_termlist_set
      create_minimal_termlist_set
      material = museum_object.materials.first
      other_ms = material.material_specifieds.where.not(name_en: 'undetermined')
      visit "/museum_objects/#{museum_object.id}/builds/step_material_specified"
      expect(page).to have_field(
                        'undetermined',
                        type: 'checkbox',
                        checked: true)
      # expect(page).to have_field(
      #                   other_ms.name_en,
      #                   type: 'checkbox',
      #                   checked: false)
    end
  end
end