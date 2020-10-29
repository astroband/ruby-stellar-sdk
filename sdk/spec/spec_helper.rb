require "bundler/setup"

require "rspec/its"
require "yaml"

require "simplecov"
SimpleCov.start

require "stellar-sdk"

Dir["support/**/*.rb", base: __dir__].sort.each { |f| require_relative f }

CONFIG = YAML.load_file(File.expand_path("config.yml", __dir__)).with_indifferent_access

RSpec.configure do |config|
  config.include Stellar::DSL
  config.filter_run_when_matching focus: true
  config.run_all_when_everything_filtered = true

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
