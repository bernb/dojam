require 'rails_helper'

feature 'Administration sections', type: :system do
  context 'user has extended access' do
    let(:user) { create :ext_user }

    scenario 'user can access administrative sections' do
      sign_in user
      visit 'import_termlists/select'
      expect(page).not_to have_text('not authorized')
      expect(page).to have_button('import')
    end

    scenario 'user can access admin dashboards' do
      sign_in user
      visit 'admin'
      expect(page).to have_text('home')
    end
  end

  context 'user has not extended access' do
    let(:user) { create :user }
    let(:not_authorized_text) {/not.authorized/} # We use a regex so that missing translations do not fail the tests

    scenario 'user can not access administrative sections' do
      sign_in user
      visit 'import_termlists/select'
      expect(page).to have_text(not_authorized_text)
      expect(page).not_to have_link('import')
    end

    scenario 'user can not access admin dashboards' do
      sign_in user
      visit 'admin'
      expect(page).not_to have_link('museum objects')
      expect(page).to have_text(not_authorized_text)
    end

    scenario 'user can not access admin termlist dashboard' do
      sign_in user
      visit 'admin/termlists'
      expect(page).not_to have_text('termlists')
      expect(page).not_to have_link('New termlist')
      expect(page).to have_text(not_authorized_text)
    end
  end

  # ToDo: Test remaining static page actions
end

feature 'Show the main menu', type: :system do
  context 'user has extended access' do
    let(:user) { create :ext_user }
    scenario 'user can see all entries' do
      sign_in user
      visit '/'
      expect(page).to have_link('import termlists')
      expect(page).to have_text('administration')
    end
  end
  context 'user has not extended access' do
    let(:user) { create :user }
    scenario 'user can not see administration links' do
      sign_in user
      visit '/'
      expect(page).not_to have_link('import termlists')
      expect(page).not_to have_link('administration')
      expect(page).not_to have_text('administration')
    end
  end
end

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

feature 'Normal users must have an associated museum', type: :system do
  context 'user has no associated museum' do
    let(:user) { create :user_without_museum }
    scenario "tries to access '/'" do
      sign_out @user
      sign_in user
      visit '/'
      expect(page).to have_text('log in')
    end
  end
  context 'user has an associated museum' do
    # We use the default @user that get created within a before_suite callback
    scenario "tries to access '/'" do
      visit '/'
      expect(page).not_to have_text('log in')
    end
  end
end