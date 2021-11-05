require 'rails_helper'

RSpec.feature "A system test that always fails", type: :system do
  scenario "true equals false" do
    expect(true).to be false
  end
end