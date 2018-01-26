# frozen_string_literal: true

module RailsEnvCredentials
  module CredentialsOverwrite
    def credentials
      @credentials ||= RailsEnvCredentials.credentials
    end
  end
end
