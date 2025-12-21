require 'capybara/rspec'
require 'selenium/webdriver'

Capybara.register_driver :selenium_firefox do |app|
  options = Selenium::WebDriver::Firefox::Options.new

  options.add_argument('--window-size=1400,900')

  Capybara::Selenium::Driver.new(
    app,
    browser: :firefox,
    options: options
  )
end


Capybara.default_driver    = :selenium_firefox
Capybara.javascript_driver = :selenium_firefox