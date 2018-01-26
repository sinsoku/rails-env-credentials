# frozen_string_literal: true

module RailsEnvCredentials
  class Railtie < ::Rails::Railtie
    initializer 'rails-env-credentials' do
      Rails::Application.prepend(CredentialsOverwrite)
    end
  end
end
