# frozen_string_literal: true

RSpec.describe RailsEnvCredentials do
  def valid_development_options
    {
      config_path: "config/credentials-development.yml.enc",
      env_key: "RAILS_MASTER_KEY_DEVELOPMENT",
      key_path: "config/master-development.key",
      raise_if_missing_key: false,
    }
  end

  def valid_production_options
    {
      config_path: "config/credentials.yml.enc",
      env_key: "RAILS_MASTER_KEY",
      key_path: "config/master.key",
      raise_if_missing_key: false,
    }
  end

  describe ".config_path=" do
    subject { RailsEnvCredentials.options }

    context "when the argument is 'credentials-development.yml.enc'" do
      let(:config_path) { 'credentials-development.yml.enc' }
      before { RailsEnvCredentials.config_path = config_path }
      it { is_expected.to eq valid_development_options.merge(config_path: config_path) }
    end

    context "when the argument is 'credentials.yml.enc'" do
      let(:config_path) { 'credentials.yml.enc' }
      before { RailsEnvCredentials.config_path = config_path }
      it { is_expected.to eq valid_production_options.merge(config_path: config_path) }
    end
  end

  describe ".env=" do
    subject { RailsEnvCredentials.options }

    context "when the argument is 'development'" do
      before { RailsEnvCredentials.env = "development" }
      it { is_expected.to eq valid_development_options }
    end

    context "when the argument is 'production'" do
      before { RailsEnvCredentials.env = "production" }
      it { is_expected.to eq valid_production_options }
    end
  end

  describe '.config' do
    before { RailsEnvCredentials.instance_variable_set(:@config, nil) }
    subject { RailsEnvCredentials.options }

    context "when Rails.env is 'development'" do
      it { is_expected.to eq valid_development_options }
    end

    context "when Rails.env is 'production'" do
      before { allow(Rails).to receive(:env) { ActiveSupport::StringInquirer.new('production') } }
      it { is_expected.to eq valid_production_options }
    end
  end
end
