# frozen_string_literal: true

module RailsEnvCredentials
  module CredentialsOverwrite
    # refs: https://github.com/rails/rails/blob/v5.2.3/railties/lib/rails/application.rb#L441
    def credentials
      @credentials ||= RailsEnvCredentials.encrypted(raise_if_missing_key: config.require_master_key)
    end
  end

  class Railtie < ::Rails::Railtie
    config.before_configuration do
      is_credentials_command = Rails.const_defined?(:Command) &&
        Rails::Command.const_defined?(:CredentialsCommand) &&
        !Rails::Command.const_defined?(:EnvCredentialsCommand)

      Rails::Application.prepend(CredentialsOverwrite) unless is_credentials_command
    end
  end
end
