# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rails_env_credentials/version"

Gem::Specification.new do |spec|
  spec.name          = "rails-env-credentials"
  spec.version       = RailsEnvCredentials::VERSION
  spec.authors       = ["sinsoku"]
  spec.email         = ["sinsoku.listy@gmail.com"]

  spec.summary       = "It enhances the credentials configuration introduced by Rails v5.2.0"
  spec.description   = "It enhances the credentials configuration introduced by Rails v5.2.0"
  spec.homepage      = "https://github.com/sinsoku/rails-env-credentials"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 5.2.0.rc1"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov"
end
