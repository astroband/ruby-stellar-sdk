# coding: utf-8
require_relative './lib/stellar/base/version'

Gem::Specification.new do |spec|
  spec.name          = "stellar-base"
  spec.version       = Stellar::Base::VERSION
  spec.authors       = ["Scott Fleckenstein"]
  spec.email         = ["scott@stellar.org"]
  spec.summary       = %q{Stellar client library: XDR}
  spec.homepage      = "https://github.com/bloom-solutions/ruby-stellar-base"
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["generated", "lib"]

  spec.add_dependency "xdr", "~> 3.0.0"
  spec.add_dependency "digest-crc"
  spec.add_dependency "base32"
  spec.add_dependency "rbnacl", ">= 6.0"
  spec.add_dependency "activesupport", ">= 5.2.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "xdrgen"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "octokit"
  spec.add_development_dependency "netrc"
  spec.add_development_dependency "yard"

end
