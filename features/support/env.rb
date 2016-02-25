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

Cucumber::Rails::Database.javascript_strategy = :truncation

World FactoryGirl::Syntax::Methods
World SessionsHelper

Capybara.register_driver :firefox do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox)
end

Capybara.javascript_driver = :firefox

Capybara.default_wait_time = 15
