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
  end
end
