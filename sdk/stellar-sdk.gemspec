# frozen_string_literal: true

require_relative "lib/stellar/sdk/version"

version = Stellar::SDK::VERSION

Gem::Specification.new do |spec|
  spec.name = "stellar-sdk"
  spec.version = version
  spec.authors = ["Scott Fleckenstein", "Sergey Nebolsin", "Timur Ramazanov"]
  spec.summary = "Stellar client library"
  spec.homepage = "https://github.com/stellar/ruby-stellar-sdk/tree/master/sdk"
  spec.license = "Apache-2.0"

  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files += Dir["README*", "LICENSE*", "CHANGELOG*"]
  spec.require_paths = ["lib"]
  spec.bindir = "exe"

  spec.metadata = {
    "documentation_uri" => "https://rubydoc.info/gems/stellar-sdk/#{version}/",
    "changelog_uri" => "https://github.com/astroband/ruby-stellar-sdk/blob/v#{version}/sdk/CHANGELOG.md",
    "source_code_uri" => "https://github.com/astroband/ruby-stellar-sdk/tree/v#{version}/sdk"
  }

  spec.required_ruby_version = ">= 2.3.0"

  spec.add_dependency "stellar-base", version

  spec.add_dependency "activesupport", ">= 5.0.0", "< 7.0"
  spec.add_dependency "excon", ">= 0.71.0", "< 1.0"
  spec.add_dependency "hyperclient", ">= 0.7.0", "< 1.0"
  spec.add_dependency "toml-rb", ">= 1.1.1", "< 3.0"
end
