# frozen_string_literal: true

module RailsEnvCredentials
  module EnvironmentLoading
    def edit
      extract_environment_option_from_argument
      ENV["RAILS_ENV"] = options[:environment]
      super
    end

    def show
      extract_environment_option_from_argument
      ENV["RAILS_ENV"] = options[:environment]
      super
    end
  end
end
