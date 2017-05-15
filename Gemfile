ruby '2.3.4'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'attr_encrypted', '~> 3.0.0'
gem 'jbuilder', '~> 2.5'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.0'
gem 'redis', '~> 3.0'
gem 'sidekiq'
gem 'pg'
gem 'dotenv'
gem 'pager_api'
gem 'kaminari'

group :test do
  gem 'cucumber-api'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
end

group :staging, :production do
end
