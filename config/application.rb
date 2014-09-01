require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dir[File.join(File.expand_path('app/jobs'), '*.rb')].each { |f| require f }

require_relative '../lib/assets/caliber_template'

module ThetvdbFeeder
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # config.middleware.insert_before ActionDispatch::Static, Rack::Deflater

    Resque.redis = ENV['REDISCLOUD_URL'] if Rails.env.production?

    def tvdb_api_key
      raise 'TheTVDB api key is not set' if ENV['TVDB_API_KEY'].nil?
      ENV['TVDB_API_KEY']
    end
  end
end
