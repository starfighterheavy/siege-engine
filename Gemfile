ruby '2.5.1'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'attr_encrypted', '> 3.0.0'
gem 'bootsnap'
gem 'dotenv'
gem 'dotenv-rails'
gem 'jbuilder', '> 2.5'
gem 'pg'
gem 'puma', '> 3.7'
gem 'rails', '~> 5.2'
gem 'redis', '> 3.0'
gem 'sidekiq'
gem 'rails-rapido'

group :test do
  gem 'cucumber', '~> 3.1'
  # Use: Testing framework
  # URL: https://github.com/cucumber/cucumber-ruby

  gem 'cucumber-api-steps'

  gem 'cucumber-rails', '>= 1.6', require: false
  # Use: Rails adapter for cucumber
  # URL: https://github.com/cucumber/cucumber-rails

  gem 'database_cleaner', '~> 1.6'
  # Use: Cleans test data between test runs
  # URL: https://github.com/DatabaseCleaner/database_cleaner
end

group :development, :test do
  gem 'awesome_print'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry'
  gem 'rspec'
  gem 'webmock'
end

group :staging, :production do
end
