ENV['RAILS_ENV'] = 'test'

require 'cucumber/rails'
require 'cucumber/rspec/doubles'
require 'simplecov'

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
