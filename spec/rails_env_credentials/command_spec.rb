# frozen_string_literal: true

RSpec.describe 'rails_env_credentials/command' do
  module NoSystemMethod
    def system(*); end
  end

  let(:key_path) { "config/new_master.key" }
  before do
    RailsEnvCredentials.configure { |config| config.default[:key_path] = key_path }
    require 'rails_env_credentials/command'
    Rails::Command::CredentialsCommand.include(NoSystemMethod)
  end

  describe "Rails::Command::CredentialsCommand" do
    let!(:ignore) { File.read('.gitignore') }
    after do
      File.write('.gitignore', ignore)
      File.delete('config/credentials.yml.enc')
      File.delete(key_path)
    end

    subject { Rails::Command.invoke("credentials:edit", ["-e", "production"]) }
    it do
      expect { subject }.to output(a_string_including(
        "create  #{key_path}",
        "append  .gitignore",
        "New credentials encrypted and saved."
      )).to_stdout
    end
  end

  describe "Rails::Generators::CredentialsGenerator#credentials" do
    it do
      generator = Rails::Generators::CredentialsGenerator.new
      credentials = generator.send(:credentials)
      expect(credentials).to be_a(RailsEnvCredentials::EncryptedConfiguration)
    end
  end
end
