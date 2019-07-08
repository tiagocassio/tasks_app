# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Conviso
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Where the I18n library should search for translation files
    config.i18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
    # Whitelist locales available for the application
    config.i18n.available_locales = %i[en pt-BR]
    # Set default locale to something other than :en
    config.i18n.default_locale = :'pt-BR'

    # Rack attack
    config.middleware.use Rack::Attack

    # Lograge config
    config.lograge.enabled = true
    config.lograge.formatter = Lograge::Formatters::Logstash.new

    # Disable assets and helper generators
    config.generators.assets = false
    config.generators.helper = false

    # Active Storage variant processor
    config.active_storage.variant_processor = :vips

    # Send logs to STDOUT
    config.log_level = ENV['LOG_LEVEL']
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.log_tags = %i[subdomain uuid]
    config.logger = ActiveSupport::TaggedLogging.new(logger)

    # Cache config
    config.cache_store = :redis_cache_store, { driver: :hiredis, url: "#{ENV['REDIS_URL']}/#{ENV['REDIS_CACHE_PATH']}" }

    # Don't generate system test files.
    config.generators.system_tests = nil

    # JSON encoding
    ActiveSupport::JSON::Encoding.time_precision = 0
  end
end
