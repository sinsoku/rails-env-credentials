# frozen_string_literal: true

module RailsEnvCredentials
  module CredentialsOverwrite
    def credentials
      @credentials ||= RailsEnvCredentials.credentials
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
