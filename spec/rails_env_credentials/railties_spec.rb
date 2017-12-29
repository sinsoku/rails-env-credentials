# frozen_string_literal: true

RSpec.describe RailsEnvCredentials::Railtie do
  describe "Rails.application.credentials" do
    subject { Rails.application.credentials }
    it { is_expected.to be_a(RailsEnvCredentials::EncryptedConfiguration) }
  end
end
