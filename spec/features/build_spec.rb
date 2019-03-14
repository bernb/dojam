require 'rails_helper'

RSpec.feature "Add new object steps", js: true, type: :feature do
  scenario "User starts adding a new object from home" do
    visit '/'
    click_link "new entry"
    expect(page).to have_text("add new object")
  end

  scenario "User adds a new object with valid location and leave rest to default" do
    visit '/museum_objects/new'
    select('hall A', from: 'storage_storage_id')
    select('showcase A1', from: 'museum_object_storage_location_id')
  end

end
