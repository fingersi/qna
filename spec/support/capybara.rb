require 'capybara/rspec'
require 'selenium/webdriver'

Capybara.register_driver :firefox do |app|

  options = Selenium::WebDriver::Firefox::Options.new

  options.add_argument('--headless')
  options.add_argument('--window-size=1400,900')
  options.log_level = 'fatal' 

  service = Selenium::WebDriver::Service.firefox
  service.executable_path = "geckodriver"

  Capybara.server_host = '127.0.0.1' # Не используйте 'localhost'!
  Capybara.app_host = "http://127.0.0.1"
  Capybara.server_port = 3001
  Capybara.always_include_port = true

  Capybara.default_max_wait_time = 10

  Capybara::Selenium::Driver.new(
    app,
    browser: :firefox,
    options: options
  )
end

Capybara.javascript_driver = :firefox_silent
