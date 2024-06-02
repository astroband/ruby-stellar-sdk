# frozen_string_literal: true

require_relative "../base/lib/stellar/version"

Gem::Specification.new do |spec|
  spec.name = "stellar-xdr"
  spec.version = Stellar::VERSION
  spec.authors = ["Sergey Nebolsin"]
  spec.summary = "Stellar client library: XDR"
  spec.homepage = "https://github.com/astroband/ruby-stellar-sdk"
  spec.license = "Apache-2.0"

  spec.description = <<~MSG
    The stellar-xdr library contains classes to work with XDR structures used by Stellar protocol.
    Both `curr` and `next` versions of protocol supported.
  MSG

  spec.files = Dir["lib/**/*", "generated/**/*"]
  spec.extra_rdoc_files += Dir["README*", "LICENSE*", "CHANGELOG*"]
  spec.require_paths = %w[generated lib]
  spec.bindir = "exe"

  spec.metadata = {
    "bug_tracker_uri" => "#{spec.homepage}/issues",
    "changelog_uri" => "#{spec.homepage}/blob/v#{spec.version}/xdr/CHANGELOG.md",
    "documentation_uri" => "https://rubydoc.info/gems/#{spec.name}/#{spec.version}/",
    "github_repo" => spec.homepage.sub("https", "ssh"),
    "homepage_uri" => "#{spec.homepage}/tree/main/xdr",
    "source_code_uri" => "#{spec.homepage}/tree/v#{spec.version}/xdr"
  }

  spec.required_ruby_version = ">= 2.5.0"

  spec.add_dependency "xdr", ">= 3.0.3", "< 4.0"
end
