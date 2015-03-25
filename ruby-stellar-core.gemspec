# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stellar/core/version'

Gem::Specification.new do |spec|
  spec.name          = "stellar-core"
  spec.version       = Stellar::Core::VERSION
  spec.authors       = ["Scott Fleckenstein"]
  spec.email         = ["scott@stellar.org"]
  spec.summary       = %q{Stellar client library: XDR}
  spec.homepage      = ""
  spec.license       = "ISC"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["generated", "lib"]

  spec.add_dependency "xdr"
  spec.add_dependency "rbnacl"
  spec.add_dependency "activesupport", "~> 4"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "xdrgen"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "octokit"
  spec.add_development_dependency "netrc"
  spec.add_development_dependency "yardoc"

end
