# frozen_string_literal: true

require "rails/command/environment_argument"
require "rails/commands/credentials/credentials_command"
require "rails_env_credentials"

using(Module.new do
  refine Module do
    def const_set!(name, value)
      remove_const(name)
      const_set(name, value)
    end
  end
end)

module Rails
  module Command
    class EnvCredentialsCommand < Rails::Command::CredentialsCommand
      include EnvironmentArgument

      argument :file, optional: true, banner: "file"
      class_option :file, aliases: "-f", type: :string

      def edit
        set_credentials_env_from_argument!
        super
      end

      def show
        set_credentials_env_from_argument!
        super
      end

      private

      def set_credentials_env_from_argument!
        extract_environment_option_from_argument

        if options.file
          RailsEnvCredentials.config_path = options.file
        elsif available_environments.include?(options.environment)
          RailsEnvCredentials.env = options[:environment]
        else
          raise "'#{options.environment}' environment is not found. Available: #{available_environments}"
        end
      end

      def master_key_generator
        require "rails/generators"
        require "rails/generators/rails/master_key/master_key_generator"

        key_path = RailsEnvCredentials.options[:key_path]
        Rails::Generators::MasterKeyGenerator.const_set!(:MASTER_KEY_PATH, Pathname.new(key_path))
        Rails::Generators::MasterKeyGenerator.new
      end

      def credentials_generator
        require "rails/generators"
        require "rails/generators/rails/credentials/credentials_generator"

        Rails::Generators::CredentialsGenerator.prepend(RailsEnvCredentials::CredentialsOverwrite)
        Rails::Generators::CredentialsGenerator.new
      end
    end
  end
end
