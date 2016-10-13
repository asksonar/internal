require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Internal
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths += %W(#{config.root}/lib)

    # load fonts that aren't just in the font folders
    config.assets.precompile << /\.(?:svg|eot|woff|woff2|ttf)$/

    # log to stdout to dump onto docker logs
    config.logger = Logger.new(STDOUT)
    config.logger.level = Logger.const_get(ENV['LOG_LEVEL'] ? ENV['LOG_LEVEL'].upcase : 'DEBUG')
    config.log_level    = (ENV['LOG_LEVEL'] ? ENV['LOG_LEVEL'].downcase : 'debug').to_sym

    config.exceptions_app = self.routes

    config.action_dispatch.rescue_responses.merge!(
      'ActionController::ForbiddenError' => :forbidden
    )

    config_path = File.join(Rails.root, "config/properties/#{ENV['SONAR_ENV']}.yml")
    config_contents = File.read(config_path)
    config.properties = YAML.load(config_contents)
    puts config.properties

    # add mail configurations for use by devise to send forgot password mails
    config.action_mailer.default_url_options = { host: 'my.asksonar.com' }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address:              'smtp.sparkpostmail.com',
      port:                 587,
      domain:               'my.asksonar.com',
      user_name:            config.properties['sparkpost_username'],
      password:             config.properties['sparkpost_api_key'],
      authentication:       'plain'
    }
  end
end
