# frozen_string_literal: true

require 'simplecov'
require 'webmock/rspec'
require 'rspec/json_expectations'
require 'aasm/rspec'
require_relative '../config/application'

SimpleCov.start 'rails' do
  add_filter '/bin/'
  add_filter '/db/'
  add_filter 'lib'
  add_filter 'lib'
  add_filter '/spec/'
  add_filter '/test/'
  add_filter 'config'
  add_filter '/app/jobs/'
  add_filter '/app/channels/'
  add_filter '/app/mailers/'
  add_filter '/app/helpers/'
  add_filter '/app/controllers/application_controller.rb'
  add_filter '/app/serializers/'
  add_filter '/app/models/ability.rb'
end

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Configure Devise to work with Capybara
  config.include Warden::Test::Helpers
  config.after :each do
    Warden.test_reset!
  end
end
