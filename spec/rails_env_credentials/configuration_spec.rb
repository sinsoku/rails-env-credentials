# frozen_string_literal: true

RSpec.describe RailsEnvCredentials::Configuration do
  describe "#credentials" do
    let(:config) { described_class.new }

    context "when no customize" do
      let(:credentials) { config.credentials }

      it "returns credentials using default values" do
        expect(credentials.content_path).to eq Rails.root.join("config/credentials.yml.enc")
        expect(credentials.key_path).to eq Rails.root.join("config/master.key")
        expect(credentials.env_key).to eq 'RAILS_MASTER_KEY'
        expect(credentials.raise_if_missing_key).to be false
        expect(config).not_to be_include_env
      end
    end

    context "when the default value is changed" do
      before { config.default[:include_env] = true }

      it "changes the value in development" do
        expect(config).to be_include_env
      end

      it "changes the value in production" do
        allow(Rails).to receive(:env) { "production" }
        expect(config).to be_include_env
      end
    end

    context "when the value is changed in development" do
      before { config.development = { include_env: true } }

      it "changes the value in development" do
        expect(config).to be_include_env
      end

      it "does not change the value in production" do
        allow(Rails).to receive(:env) { "production" }
        expect(config).not_to be_include_env
      end
    end
  end
end
