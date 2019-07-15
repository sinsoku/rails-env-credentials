# frozen_string_literal: true

RSpec.describe RailsEnvCredentials do
  def valid_test_options
    {
      config_path: "config/credentials-test.yml.enc",
      env_key: "RAILS_MASTER_KEY_TEST",
      key_path: "config/master-test.key"
    }
  end

  def valid_production_options
    {
      config_path: "config/credentials.yml.enc",
      env_key: "RAILS_MASTER_KEY",
      key_path: "config/master.key"
    }
  end

  describe ".config_path=" do
    subject { RailsEnvCredentials.config.to_h }

    context "when the argument is 'credentials-development.yml.enc'" do
      let(:config_path) { 'credentials-test.yml.enc' }
      before { RailsEnvCredentials.config_path = config_path }
      it { is_expected.to eq valid_test_options.merge(config_path: config_path) }
    end

    context "when the argument is 'credentials.yml.enc'" do
      let(:config_path) { 'credentials.yml.enc' }
      before { RailsEnvCredentials.config_path = config_path }
      it { is_expected.to eq valid_production_options.merge(config_path: config_path) }
    end
  end

  describe ".env=" do
    subject { RailsEnvCredentials.config.to_h }

    context "when the argument is 'test'" do
      before { RailsEnvCredentials.env = "test" }
      it { is_expected.to eq valid_test_options }
    end

    context "when the argument is 'production'" do
      before { RailsEnvCredentials.env = "production" }
      it { is_expected.to eq valid_production_options }
    end
  end

  describe '.config' do
    before { RailsEnvCredentials.instance_variable_set(:@config, nil) }
    subject { RailsEnvCredentials.config.to_h }

    context "when Rails.env is 'test'" do
      it { is_expected.to eq valid_test_options }
    end

    context "when Rails.env is 'production'" do
      before { allow(Rails).to receive(:env) { ActiveSupport::StringInquirer.new('production') } }
      it { is_expected.to eq valid_production_options }
    end
  end
end
