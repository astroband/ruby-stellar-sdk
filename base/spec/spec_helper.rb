require "rspec/its"
require "simplecov"
SimpleCov.start

require "stellar-base"

Dir["support/**/*.rb", base: __dir__].sort.each { |f| require_relative f }

RSpec.configure do |config|
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
