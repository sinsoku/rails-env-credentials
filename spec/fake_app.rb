# frozen_string_literal: true

module FakeApp
  class Application < Rails::Application
    config.eager_load = false
    config.logger = Logger.new(nil).tap do |log|
      def log.write(msg); end
    end
  end
end
FakeApp::Application.initialize!
