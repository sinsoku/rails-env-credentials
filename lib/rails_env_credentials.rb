# frozen_string_literal: true

require "rails"
require "rails_env_credentials/config"
require "rails_env_credentials/railtie"
require "rails_env_credentials/version"

module RailsEnvCredentials
  class << self
    def config_path=(path)
      if path.end_with?('credentials.yml.enc')
        env = 'production'
      else
        env = /-(\w+)\.yml\.enc\Z/.match(path).to_a[1]
      end
      @config = Config.new(env: env, config_path: path)
    end

    def env=(env)
      @config = Config.new(env: env)
    end

    def options
      (@config || Config.new).to_options
    end

    def credentials
      ActiveSupport::EncryptedConfiguration.new(options)
    end
  end
end
