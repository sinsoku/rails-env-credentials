require "bundler/setup"
require "rails-env-credentials"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  ignore_content = File.read(".gitignore")
  config.after(:suite) { File.write(".gitignore", ignore_content) }
end

ENV['RAILS_ENV'] ||= 'test'

require "rails/command"
require "fake_app"
