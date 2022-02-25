require 'rails_helper'

feature 'Add a new object' do
  feature 'step_acquisition', type: :system, js: true do
    let!(:museum_object)                { create :mo_at_step_acquisition }
    let(:kind_of_acquisition_select)          { 'museum_object[acquisition_kind_id]' }
    let(:delivered_by_select)                 { 'museum_object[acquisition_delivered_by_id]' }
    let(:acquisition_date_unknown_checkbox)   { 'museum_object[acquisition_date_unknown]' }
    let(:acquisition_year_select)             { 'museum_object[acquisition_year]' }
    let(:acquisition_month_select)            { 'museum_object[acquisition_month]' }
    let(:acquisition_day_select)              { 'museum_object[acquisition_day]' }

    before(:each) do
      visit "/museum_objects/#{museum_object.id}/builds/step_acquisition"
    end

    scenario 'form has correct default values' do
      expect(page).to have_select(kind_of_acquisition_select,
                                  selected: 'undetermined')
      expect(page).to have_select(delivered_by_select,
                                  selected: 'undetermined')
      expect(page).to have_checked_field(acquisition_date_unknown_checkbox)
      expect(page).to have_select(acquisition_year_select, disabled: true)
      expect(page).to have_select(acquisition_month_select, disabled: true)
      expect(page).to have_select(acquisition_day_select, disabled: true)
    end

    scenario 'user sets acquisition date' do
      uncheck acquisition_date_unknown_checkbox
      expect(page).to have_select(acquisition_year_select,
                                  disabled: false,
                                  with_options: ['', '1900'])
      expect(page).to have_select(acquisition_month_select,
                                  disabled: false,
                                  with_options: ['', '1', '12'])
      expect(page).to have_select(acquisition_day_select,
                                  disabled: false,
                                  with_options: ['', '1', '31'])
    end

    scenario 'user rechecks acquisition unknown checkbox' do
      check acquisition_date_unknown_checkbox
      expect(page).to have_select(acquisition_year_select,
                                  disabled: true,
                                  selected: '')
      expect(page).to have_select(acquisition_month_select,
                                  disabled: true,
                                  selected: '')
      expect(page).to have_select(acquisition_day_select,
                                  disabled: true,
                                  selected: '')
    end

    scenario 'user confirms default choices' do
      click_button 'confirm'
      expect(page).not_to have_css '.alert-warning'
      expect(page).to have_current_path(/step_provenance/)
    end

    scenario 'created terms show up in correct order' do
      create(:acquisition_kind, name_en: 'undetermined')
      create(:acquisition_delivered_by, name_en: 'undetermined')
      create_list(:acquisition_kind, 12)
      create_list(:acquisition_delivered_by, 12)
      visit "/museum_objects/#{museum_object.id}/builds/step_acquisition"
      expect(page).to have_select(kind_of_acquisition_select,
                                  selected: 'undetermined')
      expect(page).to have_select(delivered_by_select,
                                  selected: 'undetermined')
      expect(page
               .find_field(kind_of_acquisition_select)
               .find(':last-child')
               .text)
        .to eq('undetermined')
      expect(page
               .find_field(delivered_by_select)
               .find(':last-child')
               .text)
        .to eq('undetermined')
    end
  end
end