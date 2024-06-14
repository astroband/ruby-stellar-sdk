# frozen_string_literal: true

require_relative "lib/stellar/ecosystem/version"

Gem::Specification.new do |spec|
  spec.name = "stellar-ecosystem"
  spec.version = Stellar::VERSION
  spec.authors = ["Timur Ramazanov", "Sergey Nebolsin"]
  spec.summary = "Stellar ecosystem library"
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

  # spec.add_dependency "activesupport", ">= 5.0.0", "< 8.0"
end
