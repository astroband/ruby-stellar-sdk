# frozen_string_literal: true

require_relative "lib/stellar/base/version"

Gem::Specification.new do |spec|
  spec.name = "stellar-base"
  spec.version = Stellar::Base::VERSION
  spec.authors = ["Scott Fleckenstein", "Sergey Nebolsin", "Timur Ramazanov"]
  spec.summary = "Stellar client library: XDR"
  spec.homepage = "https://github.com/astroband/ruby-stellar-sdk"
  spec.license = "Apache-2.0"

  spec.description = <<~MSG
    The stellar-base library is the lowest-level stellar helper library. It consists of classes to read, write,
    hash, and sign the xdr structures that are used in stellar-core.
  MSG

  spec.files = Dir["lib/**/*", "generated/**/*"]
  spec.extra_rdoc_files += Dir["README*", "LICENSE*", "CHANGELOG*"]
  spec.require_paths = %w[generated lib]
  spec.bindir = "exe"

  spec.metadata = {
    "bug_tracker_uri" => "#{spec.homepage}/issues",
    "changelog_uri" => "#{spec.homepage}/blob/v#{spec.version}/base/CHANGELOG.md",
    "documentation_uri" => "https://rubydoc.info/gems/#{spec.name}/#{spec.version}/",
    "homepage_uri" => "#{spec.homepage}/tree/main/base",
    "source_code_uri" => "#{spec.homepage}/tree/v#{spec.version}/base"
  }

  spec.metadata["github_repo"] = "ssh://github.com/astroband/ruby-stellar-sdk"

  spec.required_ruby_version = ">= 2.5.0"

  spec.add_dependency "activesupport", ">= 5.0.0", "< 7.0"
  spec.add_dependency "base32", ">= 0.3.0", "< 1.0"
  spec.add_dependency "digest-crc", ">= 0.5.0", "< 1.0"
  spec.add_dependency "rbnacl", ">= 6.0.0", "< 8.0"
  spec.add_dependency "xdr", ">= 3.0.2", "< 4.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13"
  spec.add_development_dependency "rspec", "~> 3.9"
  spec.add_development_dependency "rspec-its", "~> 1.3"
end
