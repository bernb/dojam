require 'rails_helper'

RSpec.feature "A system test that always succeeds", type: :system do
  scenario "true equals true" do
    expect(true).to be true
  end
end