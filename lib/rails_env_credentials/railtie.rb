# frozen_string_literal: true

require "rails_env_credentials/credentials_loading"

module RailsEnvCredentials
  class Railtie < ::Rails::Railtie
    initializer 'rails-env-credentials' do
      Rails::Application.prepend(CredentialsLoading)
    end
  end
end
