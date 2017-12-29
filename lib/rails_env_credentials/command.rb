# frozen_string_literal: true

require "rails_env_credentials"
require "rails_env_credentials/command/environment_loading"
require "rails_env_credentials/command/master_key_path_reloading"

# Allow environment argument in `credentials:edit` command
require "rails/command"
require "rails/commands/credentials/credentials_command"
require "rails/command/environment_argument"
Rails::Command::CredentialsCommand.include(Rails::Command::EnvironmentArgument)
Rails::Command::CredentialsCommand.prepend(RailsEnvCredentials::EnvironmentLoading)

# Reload master key path before use it
require "rails/generators"
require "rails/generators/rails/master_key/master_key_generator"
Rails::Generators::MasterKeyGenerator.prepend(RailsEnvCredentials::MasterKeyPathReloading)

# Use EnvCredentials instead of original credentials
require "rails/generators/rails/credentials/credentials_generator"
Rails::Generators::CredentialsGenerator.prepend(RailsEnvCredentials::CredentialsLoading)
