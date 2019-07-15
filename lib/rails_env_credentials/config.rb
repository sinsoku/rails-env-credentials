# frozen_string_literal: true

module RailsEnvCredentials
  class Config
    attr_reader :env

    def initialize(env: nil, config_path: nil)
      @env = env.nil? ? Rails.env : ActiveSupport::StringInquirer.new(env)
      @config_path = config_path
    end

    def config_path
      @config_path || "config/#{env_suffix("credentials")}.yml.enc"
    end

    def env_key
      env_suffix("RAILS_MASTER_KEY", "_").upcase
    end

    def key_path
      "config/#{env_suffix("master")}.key"
    end

    def to_h
      {
        config_path: config_path,
        env_key: env_key,
        key_path: key_path
      }
    end

    private

    def env_suffix(str, suffix = "-")
      env.production? ? str : [str, suffix, env].join
    end
  end
end
