require 'rails_helper'

feature 'Search for museum objects', type: :system, js: true do
  let(:museum1) { create :museum_with_storage_locations }
  let(:authenticities) {create_list(:authenticity, 5)}
  let!(:object1) { create :museum_object,
                          storage_location: museum1.storages.first.storage_locations.first,
                          remarks: 'ttt',
                          inv_number: 'T.000',
                          inv_extension: '1',
                          authenticity: authenticities.first}
  let(:museum2) { create :museum_with_storage_locations }
  let!(:object2) { create :museum_object,
                          storage_location: museum2.storages.first.storage_locations.first,
                          remarks: 'ttt',
                          inv_number: 'T.000',
                          inv_extension: '2',
                          authenticity: authenticities.first}
  context 'user has extended rights' do
    let(:user) { create :ext_user }

    scenario 'fulltext search' do
      sign_in user
      visit '/museum_objects/search'
      click_link 'fulltext'
      fill_in 'fulltext_search', with: 'ttt'
      click_on 'search'
      expect(page).to have_text('2 results')
    end

    scenario 'inv. number search with multiple results' do
      sign_in user
      visit '/museum_objects/search'
      fill_in 'inv_number_search', with: 'T.000'
      click_on 'search'
      expect(page).to have_text('T.000-1').and have_text('T.000-2')
    end

    scenario 'form search' do
      sign_in user
      visit '/museum_objects/search'
      click_link 'form'
      select 'authenticity', from: 'selected_term'
      click_link '+'
      select authenticities.first.name_en, from: 'search_form_field_authenticity'
      click_button 'search'
      expect(page).to have_text('2 results')
    end
  end

  context 'user has not extended rights' do
    let(:user) { create :user, museum: museum1 }

    scenario 'fulltext search' do
      sign_in user
      visit '/museum_objects/search'
      click_link 'fulltext'
      fill_in 'fulltext_search', with: 'ttt'
      click_on 'search'
      expect(page).to have_text('1 result')
    end

    scenario 'inv. number search with single result' do
      sign_in user
      visit '/museum_objects/search'
      fill_in 'inv_number_search', with: 'T.000'
      click_on 'search'
      expect(page).not_to have_text('T.000-2')
      expect(page).to have_text('T.000-1')
    end

    scenario 'form search' do
      sign_in user
      visit '/museum_objects/search'
      click_link 'form'
      select 'authenticity', from: 'selected_term'
      click_link '+'
      select authenticities.first.name_en, from: 'search_form_field_authenticity'
      click_button 'search'
      expect(page).to have_text('1 result')
    end
  end
end