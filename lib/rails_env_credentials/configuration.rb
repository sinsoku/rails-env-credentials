# frozen_string_literal: true

require "rails_env_credentials/encrypted_configuration"

module RailsEnvCredentials
  class Configuration
    attr_accessor :default
    delegate :[], :fetch, to: :env_config
    delegate_missing_to :env_config

    def initialize
      @default = {
        config_path: "config/credentials.yml.enc",
        key_path: "config/master.key",
        env_key: "RAILS_MASTER_KEY",
        require_master_key: false,
        include_env: false
      }
    end

    def credentials
      EncryptedConfiguration.new(
        config_path: Rails.root.join(current_config[:config_path]),
        key_path: Rails.root.join(current_config[:key_path]),
        env_key: current_config[:env_key],
        raise_if_missing_key: current_config[:require_master_key]
      )
    end

    def include_env?
      current_config[:include_env]
    end

    def key_path
      current_config[:key_path]
    end

    def reload!
      @current_config = nil
    end

    private

    def current_config
      @current_config ||= default.merge(env_config[Rails.env])
    end

    def env_config
      @env_config ||= ActiveSupport::InheritableOptions.new(
        development: {},
        test: {},
        production: {}
      )
    end
  end
end
