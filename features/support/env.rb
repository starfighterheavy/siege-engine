require 'cucumber-api'
require 'sidekiq'
require 'sidekiq/testing'

Sidekiq::Worker.clear_all

require 'dotenv'
Dotenv.load('.env.development', '.env')

%w(SE_ACCESS_KEY_ID SE_SECRET_ACCESS_KEY SE_API_URL).each do |key|
  raise "Stopping test - cannot find #{key}" unless ENV[key]
end
