# frozen_string_literal: true

require_relative "../base/lib/stellar/version"

Gem::Specification.new do |spec|
  spec.name = "stellar-sdk"
  spec.version = Stellar::VERSION
  spec.authors = ["Scott Fleckenstein", "Sergey Nebolsin", "Timur Ramazanov"]
  spec.summary = "Stellar client library"
  spec.homepage = "https://github.com/astroband/ruby-stellar-sdk"
  spec.license = "Apache-2.0"

  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files += Dir["README*", "LICENSE*", "CHANGELOG*"]
  spec.require_paths = ["lib"]
  spec.bindir = "exe"

  spec.metadata = {
    "bug_tracker_uri" => "#{spec.homepage}/issues",
    "changelog_uri" => "#{spec.homepage}/blob/v#{spec.version}/sdk/CHANGELOG.md",
    "documentation_uri" => "https://rubydoc.info/gems/#{spec.name}/#{spec.version}/",
    "github_repo" => spec.homepage.sub("https", "ssh"),
    "homepage_uri" => "#{spec.homepage}/tree/main/sdk",
    "source_code_uri" => "#{spec.homepage}/tree/v#{spec.version}/sdk"
  }

  spec.required_ruby_version = ">= 2.5.0"

  spec.add_dependency "stellar-base", spec.version
  spec.add_dependency "stellar-horizon", spec.version

  spec.add_dependency "activesupport", ">= 5.0.0", "< 8.0"
  spec.add_dependency "faraday", ">= 1.6.0", "< 3.0"
  spec.add_dependency "tomlrb", ">= 2.0.1", "< 3.0"
end
