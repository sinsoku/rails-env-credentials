# frozen_string_literal: true

module RailsEnvCredentials
  class Railtie < ::Rails::Railtie
    initializer 'rails-env-credentials' do
      is_credentials_command = Rails.const_defined?(:Command) &&
        Rails::Command.const_defined?(:CredentialsCommand) &&
        !Rails::Command.const_defined?(:EnvCredentialsCommand)
      Rails::Application.prepend(CredentialsOverwrite) unless is_credentials_command
    end
  end
end
