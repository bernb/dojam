require 'rails_helper'

feature 'Show loans out index', type: :system do
  let!(:museum1)          { create :museum_with_storage_locations }
  let!(:museum2)          { create :museum_with_storage_locations }
  let!(:object1)          { create :complete_museum_object, storage_location: museum1.storages.first.storage_locations.first }
  let!(:object2)          { create :complete_museum_object, storage_location: museum2.storages.first.storage_locations.first }
  let!(:loan1)            { create :loan_out, museum_object: object1 }
  let!(:loan2)            { create :loan_out, museum_object: object2 }
  let(:ext_user)          { create :ext_user }
  let(:user)              { create :user, museum: museum1 }

  scenario 'user has extended access' do
    sign_in ext_user
    visit '/loan_outs'
    expect(page).to have_selector('.search-result-row', count: 2)
  end

  scenario 'user has not extended access' do
    sign_in user
    visit '/loan_outs'
    expect(page).to have_selector('.search-result-row', count: 1)
  end
end