require 'rails_helper'

RSpec.feature "Add new object steps", type: :system do
  scenario "User starts adding a new object from home" do
    visit '/'
    #click_link "new entry"
    expect(page).to have_text("create main account")
  end

  # scenario "User deselects undetermined entry in material step" do
  #   museum_object = create(:valid_museum_object)
  #   visit '/museum_objects/' + museum_object.id.to_s + '/builds/step_material'
  #   undet_path_id = Path.undetermined_path.to_depth(1).id
  #   undet_checkbox_id = "#museum_object_secondary_path_ids_" + undet_path_id.to_s
  #   undet_checkbox = find(undet_checkbox_id)
  #   expect(undet_checkbox.checked?).to eq(true)
  #   ceramic_path = Material.find_by(name: 'ceramic').paths.first
  #   ceramic_checkbox = find(
  #     '#museum_object_secondary_path_ids_' + ceramic_path.id.to_s)
  #   ceramic_checkbox.click
  #   expect(undet_checkbox.checked?).to eq(false)
  # end
  #
  # scenario 'User unselects material in material step' do
  #   museum_object = create(:valid_museum_object)
  #   ceramic_id = Material.find_by(name: 'ceramic').id
  #   path = Path.material_id(ceramic_id).first
  #     .direct_children.first
  #     .direct_children.first
  #     .direct_children.first
  #   museum_object.secondary_paths = path
  #   museum_object.save!
  #   visit '/museum_objects/' + museum_object.id.to_s + '/builds/step_material'
  #   undet_path_id = Path.undetermined_path.to_depth(1).id
  #   undet_checkbox_id = "#museum_object_secondary_path_ids_" + undet_path_id.to_s
  #   undet_checkbox = find(undet_checkbox_id)
  #   expect(undet_checkbox.checked?).to eq(false)
  #   ceramic_path = Material.find_by(name: 'ceramic').paths.first
  #   ceramic_checkbox = find(
  #     '#museum_object_secondary_path_ids_' + ceramic_path.id.to_s)
  #   expect(ceramic_checkbox.checked?).to eq(true)
  #   ceramic_checkbox.click
  #   expect(undet_checkbox.checked?).to eq(true)
  # end
  #
  # scenario "User adds a new object with valid location and leave rest to default" do
  #   visit '/museum_objects/new'
  #   select('hall A', from: 'storage_storage_id')
  #   select('showcase A1', from: 'museum_object_storage_location_id')
  #   fill_in('inventory number of museum', with: 'T.1111')
  #   click_button('confirm')
  #   expect(page).to have_text("acquisition")
  #
  #   click_button('confirm')
  #   expect(page).to have_text("provenance")
  #
  #   click_button('confirm')
  #   expect(page).to have_text("material")
  #   undet_path_id = Path.undetermined_path.to_depth(1).id
  #   checkbox_id = "#museum_object_secondary_path_ids_" + undet_path_id.to_s
  #   expect(page).to have_selector(checkbox_id)
  #   checkbox = find(checkbox_id)
  #   expect(checkbox.checked?).to eq(true)
  #
  #   click_button('confirm')
  #   expect(page).to have_text("material specified")
  #   undet_path_id = Path.undetermined_path.to_depth(2).id
  #   checkbox_id = "#museum_object_secondary_path_ids_" + undet_path_id.to_s
  #   expect(page).to have_selector(checkbox_id)
  #   checkbox = find(checkbox_id)
  #   expect(checkbox.checked?).to eq(true)
  #
  #   click_button('confirm')
  #   expect(page).to have_text("primary material")
  #   undet_path_id = Path.undetermined_path.id
  #   dropdown_id = "#museum_object_main_path_id"
  #   expect(page).to have_selector(dropdown_id)
  #   expect(page.has_select?(
  #          'museum_object_main_path_id', with_options: ['undetermined'])).to eq(true)
  #
  #   click_button('confirm')
  #   expect(page). to have_text('kind of object specified')
  #   dropdown_id = "#museum_object_kind_of_object_specified_id"
  #   expect(page).to have_selector(dropdown_id)
  #   expect(page.has_select?(
  #          'museum_object_kind_of_object_specified_id', with_options: ['undetermined'])).to eq(true)
  #
  #   click_button('confirm')
  #   expect(page). to have_text('production')
  # end

end
