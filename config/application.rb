require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Atmosfeel
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # prevent ApplicationController from loading all of the helpers
    config.action_controller.include_all_helpers = false
    config.encoding = "utf-8"
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.available_locales = [:fr]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]
    config.i18n.default_locale = :fr

    # Remove field_with_error
    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      html_tag
    }

    # Custom generator
    config.generators do |g|
      g.test_framework :test_unit, fixture: true
      g.stylesheets false
      g.javascripts false
    end

    config.active_record.raise_in_transactional_callbacks = true

    initializer 'setup_asset_pipeline', :group => :all  do |app|
      # We don't want the default of everything that isn't js or css, because it pulls too many things in
      app.config.assets.precompile.shift

      # Explicitly register the extensions we are interested in compiling
      app.config.assets.precompile.push(Proc.new do |path|
        File.extname(path).in? [
          '.slim', '.json.jbuilder', '.coffee', '.js', '.html', # Templates
          '.png', '.jpg', '.gif',                                       # Images
          '.eot',  '.otf', '.svc', '.woff', '.woff2', '.ttf',             # Fonts
        ]
      end)
    end

    # Active job adapter
    config.active_job.queue_adapter = :sidekiq
  end
end
