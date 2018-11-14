require 'cucumber/rails'
require 'cucumber/api_steps'
require 'sidekiq'
require 'sidekiq/testing'
require 'rspec/expectations'
require 'awesome_print'

unless ENV['SIDEKIQ'] == 'true'
  Sidekiq::Worker.clear_all
end

require 'dotenv'
Dotenv.load('.env.test', '.env')

puts '### Configuration ###'
%w(SE_ACCESS_KEY_ID SE_SECRET_ACCESS_KEY SE_API_URL).each do |key|
  raise "Stopping test - cannot find #{key}" unless ENV[key]
  puts "#{key}=#{ENV[key]}"
end

ActiveRecord::Migration.maintain_test_schema!

ActionController::Base.allow_rescue = true

DatabaseCleaner.strategy = :transaction

Cucumber::Rails::Database.javascript_strategy = :truncation
