# RailsEnvCredentials

RailsEnvCredentials enhances the credentials configuration introduced by Rails v5.2.0.

It make that `Rails.application.credentials` returns environment specific credentials.

## Features

It supports two cases as below:

### Case 1: Specify config file per env

You can use credentials with a different file per env.

```yaml
# config/credentials-development.yml.enc
token: xxx
```

```yaml
# config/credentials.yml.enc
token: xxx
```

### Case 2: Includes env in credentials

You can include env at a root level in credentials.

```yaml
# config/credentials.yml.enc
development:
  token: xxx

test:
  token: xxx

production:
  token: xxx
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails-env-credentials'
```

Then add this to `bin/rails` before `require 'rails/commands'`:

```ruby
require 'rails_env_credentials/command'
```

## Usage

You need to configure in `config/application.rb`:

### Case 1: Specify config file per env

```ruby
# config/application.rb
RailsEnvCredentials.configure do |config|
  config.development = {
    config_path: "config/credentials-development.yml.enc",
    key_path: "config/development.key",
    env_key: "RAILS_DEVELOPMENT_KEY",
  }

  config.test = {
    config_path: "config/credentials-test.yml.enc",
    key_path: "config/test.key",
    env_key: "RAILS_TEST_KEY",
  }
end
```

### Case 2: Includes env in credentials

```ruby
# config/application.rb
RailsEnvCredentials.configure do |config|
  config.default[:include_env] = true
end
```

### How to edit credentials

If you use only one file, so execute the command normally.

```bash
$ rails credentials:edit
```

If you use multiple config files, so execute with environment arguments.

```bash
$ rails credentials:edit -e production
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sinsoku/rails-env-credentials. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rails::Env::Credentials project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rails-env-credentials/blob/master/CODE_OF_CONDUCT.md).
