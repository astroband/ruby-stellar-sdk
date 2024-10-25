# frozen_string_literal: true

require_relative "../base/lib/stellar/version"

Gem::Specification.new do |spec|
  spec.name = "stellar-horizon"
  spec.version = Stellar::VERSION
  spec.authors = ["Sergey Nebolsin", "Timur Ramazanov"]
  spec.summary = "Stellar Horizon client library"
  spec.homepage = "https://github.com/stellar/ruby-stellar-sdk/tree/master/horizon"
  spec.license = "Apache-2.0"

  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files += Dir["README*", "LICENSE*", "CHANGELOG*"]
  spec.require_paths = ["lib"]
  spec.bindir = "exe"

  spec.metadata = {
    "github_repo" => "ssh://github.com/astroband/ruby-stellar-sdk",
    "documentation_uri" => "https://rubydoc.info/gems/stellar-sdk/#{spec.version}/",
    "changelog_uri" => "https://github.com/astroband/ruby-stellar-sdk/blob/v#{spec.version}/horizon/CHANGELOG.md",
    "source_code_uri" => "https://github.com/astroband/ruby-stellar-sdk/tree/v#{spec.version}/horizon"
  }

  spec.required_ruby_version = ">= 2.5.0"

  spec.add_dependency "stellar-base", spec.version

  spec.add_dependency "excon", ">= 0.71.0", "< 2.0"
  spec.add_dependency "faraday", ">= 1.6.0", "< 3.0"
  spec.add_dependency "faraday-excon", ">= 1.1.0", "< 3.0"
  spec.add_dependency "faraday-follow_redirects", ">= 0.3.0", "< 1.0"
  spec.add_dependency "hyperclient", ">= 0.7.0", "< 3.0"
end
