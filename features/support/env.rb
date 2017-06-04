require 'cucumber-api'
require 'sidekiq'
require 'sidekiq/testing'
require 'rspec/expectations'
require 'awesome_print'

unless ENV['SIDEKIQ'] == 'true'
  Sidekiq::Worker.clear_all
end

require 'dotenv'
Dotenv.load('.env.development', '.env')

puts '### Configuration ###'
%w(SE_ACCESS_KEY_ID SE_SECRET_ACCESS_KEY SE_API_URL).each do |key|
  raise "Stopping test - cannot find #{key}" unless ENV[key]
  puts "#{key}=#{ENV[key]}"
end

%w(SE_HOST TARGET_HOST).each do |key|
  puts "#{key}=#{ENV[key]}"
end
