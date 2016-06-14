require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
# require "sprockets/railtie"
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SmartParkingApi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified
    # here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Make Rails look for files in the lib directory
    config.eager_load_paths << "#{Rails.root}/lib"

    # Make time columns be time zone aware.
    # This will be the default in Rails 5.1.
    # See https://github.com/rails/rails/pull/15726.
    config.active_record.time_zone_aware_types = [:datetime, :time]

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # Enable CORS for any host and any method.
    config.action_dispatch.default_headers.merge!(
      'Access-Control-Allow-Origin' => '*',
      'Access-Control-Request-Method' => '*'
    )
  end
end
