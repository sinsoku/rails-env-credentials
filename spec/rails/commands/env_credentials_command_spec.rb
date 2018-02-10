# frozen_string_literal: true

require "active_support/testing/stream"

RSpec.describe "Rails::Command::EnvCredentialsCommand" do
  include ActiveSupport::Testing::Stream

  after do
    Dir["config/*.yml.enc"].each { |path| FileUtils.rm_rf(path) }
    Dir["config/*.key"].each { |path| FileUtils.rm_rf(path) }
    RailsEnvCredentials.instance_variable_set(:@config, nil)
    Rails.application.instance_variable_set(:@credentials, nil)
  end

  describe "#edit" do
    context "no arguments" do
      it "generates files for the test environment" do
        quietly { run_edit_command }

        expect(File).to be_exist 'config/credentials-test.yml.enc'
        expect(File).to be_exist 'config/master-test.key'
      end
    end

    context "with the environment option" do
      it "generates files for the production environment" do
        quietly { run_edit_command(args: %w[-e production]) }

        expect(File).to be_exist 'config/credentials.yml.enc'
        expect(File).to be_exist 'config/master.key'
      end
    end
  end

  describe "#show" do
    context "no arguments" do
      it "shows credentials" do
        quietly { run_edit_command(editor: "eval echo api_key: abc >") }

        expect { run_show_command }.to output(/api_key: abc/).to_stdout
      end
    end

    context "with the file option to show credentials for other environment" do
      it "shows credentials for other environment" do
        quietly { run_edit_command(editor: "eval echo api_key: abc >", args: %w[-e production]) }

        expect { run_show_command(args: ["-f", "config/credentials.yml.enc"]) }.to output(/api_key: abc/).to_stdout
      end
    end

    context "with the file option to show credentials in temporary directory" do
      it "shows credentials in temporary directory" do
        quietly { run_edit_command(editor: "eval echo api_key: abc >") }

        Tempfile.open(['', '-test.yml.enc']) do |f|
          encrypted = File.read("config/credentials-test.yml.enc")
          f.write(encrypted)
          f.rewind

          quietly { run_edit_command(editor: "eval echo api_key: def >") }
          Rails.application.instance_variable_set(:@credentials, nil)

          expect { run_show_command(args: ["-f", f.path]) }.to output(/api_key: abc/).to_stdout
        end
      end
    end
  end

  private

  def run_edit_command(editor: ":", args: [])
    switch_env("EDITOR", editor) do
      Rails::Command.invoke("env_credentials:edit", args)
    end
  end

  def run_show_command(args: [])
    Rails::Command.invoke("env_credentials:show", args)
  end

  def switch_env(key, value)
    old, ENV[key] = ENV[key], value
    yield
  ensure
    ENV[key] = old
  end
end
