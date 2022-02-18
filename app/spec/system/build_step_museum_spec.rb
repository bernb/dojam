require 'rails_helper'

feature "Add a new object" do
  feature "step_museum", type: :system, js: true do
    let!(:museum_object)    { create(:museum_object) }
    let!(:museum)           { create(:JAM)}
    let!(:storage1)         { create :storage, museum: museum }
    let!(:storage2)         { create(:storage, museum: museum) }
    let(:inv_field)               { 'museum_object[inv_number]'}
    let(:storage_select)          { 'storage[storage_id]'}
    let(:storage_location_select) { 'museum_object[storage_location_id]'}

    before(:each) do
      visit "/museum_objects/#{museum_object.id}/builds/step_museum"
    end

    scenario "correct storage options are available" do
      expect(page).to have_select(storage_select,
                                  selected: "",
                                  options: ["",
                                            storage1.name_en,
                                            storage2.name_en])
      expect(page).to have_select(storage_location_select,
                                  selected: "",
                                  options: [""])
    end

    scenario "user selects a storage" do
      select storage1.name_en, from: storage_select
      expect(page).to have_select(storage_location_select,
                                  selected: "",
                                  with_options: storage1
                                                  .storage_locations
                                                  .map(&:name_en))
    end
  end
end