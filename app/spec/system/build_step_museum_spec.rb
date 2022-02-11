require 'rails_helper'

feature "Add a new object", type: :system do
  feature "step_museum", type: :system do
    before(:each) do
      @museum_object = create(:museum_object)
      @museum = create(:JAM)
      @storage1 = create(:storage, museum: @museum)
      @storage2 = create(:storage, museum: @museum)
      visit "museum_objects/#{@museum_object.id}/builds/step_museum"
    end

    scenario "correct storage options are available" do
      expect(page).to have_select("storage[storage_id]",
                                  selected: nil,
                                  options: ["",
                                            @storage1.name_en,
                                            @storage2.name_en])
      expect(page).to have_select("museum_object[storage_location_id]",
                                  selected: nil,
                                  options: [""])
    end

    scenario "user selects a storage" do
      expect(page).to have_select("museum_object[storage_location_id]",
                                  selected: nil)
      select @storage1.name_en, from: "storage[storage_id]"
      expect(page).to have_select("museum_object[storage_location_id]",
                                  selected: nil,
                                  with_options: @storage1
                                                  .storage_locations
                                                  .map(&:name_en))
    end
  end
end