# frozen_string_literal: true

require_relative "lib/stellar/sdk/version"

Gem::Specification.new do |spec|
  spec.name = "stellar-sdk"
  spec.version = Stellar::SDK::VERSION
  spec.authors = ["Scott Fleckenstein", "Sergey Nebolsin", "Timur Ramazanov"]
  spec.summary = "Stellar client library"
  spec.homepage = "https://github.com/stellar/ruby-stellar-sdk/tree/master/sdk"
  spec.license = "Apache-2.0"

  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files += Dir["README*", "LICENSE*", "CHANGELOG*"]
  spec.require_paths = ["lib"]
  spec.bindir = "exe"

  spec.metadata = {
    "github_repo" => "ssh://github.com/astroband/ruby-stellar-sdk",
    "documentation_uri" => "https://rubydoc.info/gems/stellar-sdk/#{spec.version}/",
    "changelog_uri" => "https://github.com/astroband/ruby-stellar-sdk/blob/v#{spec.version}/sdk/CHANGELOG.md",
    "source_code_uri" => "https://github.com/astroband/ruby-stellar-sdk/tree/v#{spec.version}/sdk"
  }

  spec.required_ruby_version = ">= 2.5.0"

  spec.add_dependency "stellar-base", spec.version

  spec.add_dependency "activesupport", ">= 5.0.0", "< 7.0"
  spec.add_dependency "excon", ">= 0.71.0", "< 1.0"
  spec.add_dependency "hyperclient", ">= 0.7.0", "< 2.0"
  spec.add_dependency "toml-rb", ">= 1.1.1", "< 3.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13"
  spec.add_development_dependency "rspec", "~> 3.9"
end
