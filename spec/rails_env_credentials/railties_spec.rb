# frozen_string_literal: true

RSpec.describe RailsEnvCredentials::Railtie do
  describe "Rails.application.credentials" do
    subject(:credentials) { Rails.application.credentials }

    it "returns credentials for development" do
      expect(credentials.content_path.to_s).to eq "config/credentials-development.yml.enc"
      expect(credentials.key_path.to_s).to eq "config/master-development.key"
      expect(credentials.env_key).to eq "RAILS_MASTER_KEY_DEVELOPMENT"
      expect(credentials.raise_if_missing_key).to be false
    end
  end
end
