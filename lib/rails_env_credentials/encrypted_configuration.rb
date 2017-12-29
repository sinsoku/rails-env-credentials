# frozen_string_literal: true

require "active_support/encrypted_configuration"

module RailsEnvCredentials
  class EncryptedConfiguration < ActiveSupport::EncryptedConfiguration
    def config
      if RailsEnvCredentials.include_env?
        super[Rails.env.to_sym] || {}
      else
        super
      end
    end
  end
end
