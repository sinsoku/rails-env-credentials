# frozen_string_literal: true

module RailsEnvCredentials
  module FileArgument
    extend ActiveSupport::Concern

    included do
      argument :file, optional: true, banner: "file"
      class_option :file, aliases: "-f", type: :string
    end
  end
end
