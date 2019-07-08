# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'aasm'
gem 'active_model_serializers', '~> 0.10.0'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'cancancan'
gem 'chartkick'
gem 'devise'
gem 'dotenv-rails'
gem 'faker'
gem 'friendly_id'
gem 'groupdate'
gem 'hiredis'
gem 'image_processing', '~> 1.2'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'kaminari'
gem 'lograge'
gem 'logstash-event'
gem 'mini_magick'
gem 'pager_api'
gem 'pagy'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rack-attack'
gem 'rack-cors'
gem 'rack-timeout'
gem 'rails', '~> 5.2.3'
gem 'rails-i18n'
gem 'ransack'
gem 'redis', '~> 4.0'
gem 'sass-rails', '~> 5.0'
gem 'seed_migration'
gem 'simple_form'
gem 'title'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'rspec-json_expectations'
  gem 'rspec-rails', '~> 3.8'
  gem 'rubocop-performance'
  gem 'rubocop-rails_config'
  gem 'rubocop-rspec'
end

group :development do
  gem 'active_record_query_trace'
  gem 'annotate'
  gem 'brakeman'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'vcr'
  gem 'webmock'
end
