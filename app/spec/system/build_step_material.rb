require 'rails_helper'

feature 'Add a new object' do
  feature 'step_material', type: :system, js: true do
    let!(:museum_object)            { create :mo_at_step_material}
    let(:material_checkboxes)             { '.museum_object_secondary_path_ids'}

    scenario 'form has correct default values' do
      material_list = create_list(:material, 6)
      visit "/museum_objects/#{museum_object.id}/builds/step_material"
      expect(page).to have_field(
                        'undetermined',
                        type: 'checkbox',
                        checked: true)
      expect(page).to have_field(
                        material_list.first.name_en,
                        type: 'checkbox',
                        checked: false)
    end

    scenario 'materials show up in correct order' do
      create_list(:material, 12)
      visit "/museum_objects/#{museum_object.id}/builds/step_material"
      expect(page
               .find(material_checkboxes)
               .find('span:last-of-type label')
               .text)
        .to eq('undetermined')
    end

    scenario 'user tries to uncheck undetermined without having selected an alternative' do
      create_list(:material, 6)
      visit "/museum_objects/#{museum_object.id}/builds/step_material"
      check 'undetermined'
      expect(page).to have_checked_field('undetermined')
    end

    scenario 'user selects a material' do
      material_list = create_list(:material, 12)
      visit "/museum_objects/#{museum_object.id}/builds/step_material"
      check material_list.first.name_en
      expect(page).not_to have_checked_field('undetermined')
    end

    scenario 'user deselects one of two materials' do
      material_list = create_list(:material, 12)
      visit "/museum_objects/#{museum_object.id}/builds/step_material"
      check material_list.first.name_en
      check material_list.second.name_en
      uncheck material_list.first.name_en
      expect(page).not_to have_checked_field('undetermined')
    end

    scenario 'user deselects all materials' do
      material_list = create_list(:material, 12)
      visit "/museum_objects/#{museum_object.id}/builds/step_material"
      check material_list.first.name_en
      check material_list.second.name_en
      uncheck material_list.first.name_en
      uncheck material_list.second.name_en
      expect(page).to have_checked_field('undetermined')
    end
  end
  end