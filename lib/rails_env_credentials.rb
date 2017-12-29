# frozen_string_literal: true

require "active_support/core_ext/module/delegation"
require "rails"

require "rails_env_credentials/configuration"
require "rails_env_credentials/credentials_loading"
require "rails_env_credentials/railtie"
require "rails_env_credentials/version"

module RailsEnvCredentials
  class << self
    delegate :credentials, :include_env?, :key_path, to: :config

    def configure
      yield config
      config.reload!
    end

    private

    def config
      @config ||= Configuration.new
    end
  end
end
