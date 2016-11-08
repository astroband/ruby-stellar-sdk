# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stellar/version'

Gem::Specification.new do |spec|
  spec.name          = "stellar-sdk"
  spec.version       = Stellar::VERSION
  spec.authors       = ["Scott Fleckenstein"]
  spec.email         = ["scott@stellar.org"]
  spec.summary       = %q{Stellar client library}
  spec.homepage      = "http://github.com/stellar/ruby-stellar-sdk"
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "stellar-base", "~> 0.11.0"
  spec.add_dependency "hyperclient", "~> 0.7.0"
  spec.add_dependency "excon", "~> 0.44.4"
  spec.add_dependency "contracts", "~> 0.7"
  spec.add_dependency "activesupport", "~> 4"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "yard"

end
