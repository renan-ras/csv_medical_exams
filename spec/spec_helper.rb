require 'active_record'
require 'capybara/rspec'
require 'database_cleaner/active_record'
require 'selenium-webdriver'
require 'rspec/wait'
require_relative '../config/database'
require_relative '../lib/csv_importer'

Capybara.register_driver :selenium do |app|
  options = Selenium::WebDriver::Chrome::Options.new(args: %w[--headless --no-sandbox --disable-gpu --window-size=1920,1080])
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :selenium
Capybara.app_host = 'http://localhost:3000'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

ActiveRecord::Base.logger.level = Logger::INFO
