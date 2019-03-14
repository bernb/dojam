require 'rails_helper'

RSpec.feature "Add new object steps", type: :feature do
  scenario "User starts adding a new object from home" do
    visit '/'
    click_link "new entry"
    expect(page).to have_text("add new object")
  end
end
