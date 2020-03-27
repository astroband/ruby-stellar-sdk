# coding: utf-8
require_relative './lib/stellar/base/version'

Gem::Specification.new do |spec|
  spec.name          = "stellar-base"
  spec.version       = Stellar::Base::VERSION
  spec.authors       = ["Scott Fleckenstein"]
  spec.email         = ["scott@stellar.org"]
  spec.summary       = %q{Stellar client library: XDR}
  spec.homepage      = "https://github.com/stellar/ruby-stellar-base"
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["generated", "lib"]

  spec.add_dependency "xdr", "~> 3.0.0"
  spec.add_dependency "digest-crc", ">= 0.5"
  spec.add_dependency "base32", ">= 0.3"
  spec.add_dependency "rbnacl", ">= 6.0"
  spec.add_dependency "activesupport", ">= 5.0.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "xdrgen", "~> 0.0"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "guard-rspec", "~> 4.7"
  spec.add_development_dependency "simplecov", "~> 0.18"
  spec.add_development_dependency "octokit", "~> 4.17"
  spec.add_development_dependency "netrc", "~> 0.11"
  spec.add_development_dependency "yard", "~> 0.9"

end
