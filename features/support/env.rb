ENV['RAILS_ENV'] = 'test'

require 'cucumber/rails'
require 'cucumber/rspec/doubles'
require 'simplecov'

# Save to CircleCI's artifacts directory if we're on CircleCI
if ENV['CIRCLE_ARTIFACTS']
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], 'coverage')
  SimpleCov.coverage_dir(dir)
end

SimpleCov.start

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise 'You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it.'
end

DatabaseCleaner.logger = Rails.logger

# Possible values are :truncation and :transaction
# The :transaction strategy is faster, but might give you threading problems.
# See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
Cucumber::Rails::Database.javascript_strategy = :truncation

World FactoryGirl::Syntax::Methods
World SessionsHelper

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :chrome

Capybara.default_wait_time = 15

# Take a screenshot when any of Cucumber's scenario failed.
# http://vumanhcuongit.github.io/testing/2016/01/26/take-screenshot-when-cucumber-test-failed
SCREENSHOT_FOLDER = File.join ENV.fetch('CIRCLE_ARTIFACTS', Rails.root.join('tmp')), 'cucumber_screenshot'

AfterConfiguration do
  FileUtils.rm_rf SCREENSHOT_FOLDER
end

After do |scenario|
  if scenario.failed?
    timestamp = "#{Time.zone.now.strftime('%Y-%m-%d, %H:%M:%S')}"
    screenshot_name = "#{scenario.title} screenshot (#{timestamp}).png"

    Capybara.page.save_screenshot File.join(SCREENSHOT_FOLDER, screenshot_name)
  end
end
