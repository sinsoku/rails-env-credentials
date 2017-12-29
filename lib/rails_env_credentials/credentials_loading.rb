# frozen_string_literal: true

module RailsEnvCredentials
  module CredentialsLoading
    def credentials
      @credentials ||= RailsEnvCredentials.credentials
    end
  end
end
