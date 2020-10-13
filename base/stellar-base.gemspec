# frozen_string_literal: true

require_relative "lib/stellar/base/version"

version = Stellar::Base::VERSION

Gem::Specification.new do |spec|
  spec.name = "stellar-base"
  spec.version = version
  spec.authors = ["Scott Fleckenstein", "Sergey Nebolsin", "Timur Ramazanov"]
  spec.summary = "Stellar client library: XDR"
  spec.homepage = "https://github.com/astroband/ruby-stellar-sdk/tree/master/base"
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
    "documentation_uri" => "https://rubydoc.info/gems/stellar-base/#{version}/",
    "changelog_uri" => "https://github.com/astroband/ruby-stellar-sdk/blob/v#{version}/base/CHANGELOG.md",
    "source_code_uri" => "https://github.com/astroband/ruby-stellar-sdk/tree/v#{version}/base"
  }

  spec.required_ruby_version = ">= 2.3.0"

  spec.add_dependency "activesupport", ">= 5.0.0", "< 7.0"
  spec.add_dependency "base32", ">= 0.3.0", "< 1.0"
  spec.add_dependency "digest-crc", ">= 0.5.0", "< 1.0"
  spec.add_dependency "rbnacl", ">= 6.0.0", "< 8.0"
  spec.add_dependency "xdr", ">= 3.0.1", "< 4.0"
end
