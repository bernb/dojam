require 'rails_helper'

feature "Main account must exist", type: :system do
  context "when not exists" do
    scenario "user tries to access '/'" do
      User.find(1).delete
      visit '/'
      expect(page).to have_text("create main account")
    end
  end

  context "when exists" do
    scenario "user tries to access '/'" do
      visit '/'
      expect(page).not_to have_text("create main account")
    end
  end
end

feature "User must be logged in", type: :system do
  context "when not logged in" do
    scenario "tries to access '/'" do
      sign_out @user
      visit '/'
      expect(page).to have_text("log in")
    end
  end

  context "when logged in" do
    scenario "tries to access '/'" do
      visit '/'
      expect(page).not_to have_text("create main account")
    end
  end
end