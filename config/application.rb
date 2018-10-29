require_relative 'boot'

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DocumentGenerator
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.assets.path = Rails.root.join("assets/wicked_pdf")

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.i18n.default_locale = 'pt-BR'
    config.time_zone = 'America/Fortaleza'
    config.active_record.default_timezone = :local
    
    config.assets.initialize_on_precompile = false

    config.generators do |g|
      g.assets            false
      g.system_tests      false
      g.test_framework    nil
      g.jbuilder          false
    end

    config.exceptions_app = self.routes
    
    config.middleware.use Rack::Attack
    
    # Config Rack-Cors
    config.middleware.insert_before 0, Rack::Cors do
 
      allow do
        origins '*'
        resource '*',
        headers: :any,
        methods: %i(get post put patch delete options head)
      end

    end
  end
end
