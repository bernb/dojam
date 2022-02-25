require 'rails_helper'

feature 'Add a new object' do
  feature 'step_provenance', type: :system, js: true do
    let!(:museum_object)                { create :mo_at_step_provenance }
    let(:site_name_select)                    { 'museum_object[excavation_site_id]' }
    let(:kind_of_site_select)                 { 'museum_object[excavation_site_category_id]' }
    let(:kind_of_site_specified_select)       { 'museum_object[excavation_site_kind_id]' }

    scenario 'form has correct default values' do
      visit "/museum_objects/#{museum_object.id}/builds/step_provenance"
      expect(page).to have_select(site_name_select,
                                  selected: 'undetermined')
      expect(page).to have_select(kind_of_site_select,
                                  selected: 'undetermined')
      expect(page).to have_select(kind_of_site_specified_select,
                                  selected: 'undetermined')
    end

    scenario 'user confirms default choices' do
      visit "/museum_objects/#{museum_object.id}/builds/step_provenance"
      click_button 'confirm'
      expect(page).not_to have_css '.alert-warning'
      expect(page).to have_current_path(/step_material/)
    end

    scenario 'site names show up in correct order' do
      create(:excavation_site, name: 'undetermined')
      create_list(:excavation_site, 12)
      visit "/museum_objects/#{museum_object.id}/builds/step_provenance"
      expect(page).to have_select(site_name_select,
                                  selected: 'undetermined')
      expect(page
               .find_field(site_name_select)
               .find(':last-child')
               .text)
        .to eq('undetermined')
    end

    scenario 'kind of sites (specified) show up in correct order' do
      create(:excavation_site_category_with_site_kinds, name_en: 'undetermined')
      create_list(:excavation_site_category_with_site_kinds, 12)
      visit "/museum_objects/#{museum_object.id}/builds/step_provenance"
      expect(page).to have_select(kind_of_site_select,
                                  selected: 'undetermined')
      expect(page).to have_select(kind_of_site_specified_select,
                                  selected: 'undetermined')
      expect(page
               .find_field(kind_of_site_select)
               .find(':last-child')
               .text)
        .to eq('undetermined')
      expect(page
               .find_field(kind_of_site_specified_select)
               .find(':last-child')
               .text)
        .to eq('undetermined')
    end
    end
  end