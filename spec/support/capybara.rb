require "capybara/rspec"
require "selenium/webdriver"

Capybara.server_host = "127.0.0.1"
Capybara.app_host = "http://127.0.0.1"
Capybara.server_port = 3001
Capybara.always_include_port = true

Capybara.default_max_wait_time = 10

Capybara.register_driver :chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--window-size=1400,900")
  options.add_argument("--disable-gpu")
  options.add_argument("--no-sandbox") # иногда нужно в Linux/CI
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--disable-extensions')
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
  )
end

Capybara.register_driver :chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--headless=new")
  options.add_argument("--window-size=1400,900")
  options.add_argument("--disable-gpu")
  options.add_argument("--no-sandbox")

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
  )
end

Capybara.javascript_driver = :chrome
