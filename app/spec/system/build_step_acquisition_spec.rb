require 'rails_helper'

feature 'Add a new object' do
  feature 'step_museum', type: :system, js: true do
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
  end
end