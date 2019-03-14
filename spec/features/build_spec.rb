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
    fill_in('inventory number of museum', with: 'T.1111')
    click_button('next step')
    expect(page).to have_text("acquisition")

    click_button('next step')
    expect(page).to have_text("provenance")

    click_button('next step')
    expect(page).to have_text("material")
    undet_path_id = Path.undetermined_path.to_depth(1).id
    expect(page).to have_selector(
      "#museum_object_secondary_path_ids_" + undet_path_id.to_s)

    click_button('next step')
    expect(page).to have_text("material specified")
    undet_path_id = Path.undetermined_path.to_depth(2).id
    expect(page).to have_selector(
      "#museum_object_secondary_path_ids_" + undet_path_id.to_s)
  end

end
