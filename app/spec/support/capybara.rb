RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end
end

Capybara.register_driver :chrome_headless do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new

  options.add_argument('--headless')
  options.add_argument('--no-sandbox')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end