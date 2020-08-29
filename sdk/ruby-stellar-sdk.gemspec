require_relative "./lib/stellar/version"

Gem::Specification.new do |spec|
  spec.name = "stellar-sdk"
  spec.version = Stellar::VERSION
  spec.authors = ["Scott Fleckenstein"]
  spec.email = ["scott@stellar.org"]
  spec.summary = "Stellar client library"
  spec.homepage = "http://github.com/stellar/ruby-stellar-sdk"
  spec.license = "Apache-2.0"

  spec.files = Dir[
    "lib/**/*",
    "README.md",
    "CHANGELOG.md",
    "LICENSE",
  ]
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "stellar-base", Stellar::VERSION
  spec.add_dependency "hyperclient", "~> 0.7"
  spec.add_dependency "excon", "~> 0.71"
  spec.add_dependency "activesupport", ">= 5.0"
  spec.add_dependency "toml-rb", ">= 1.1.1", "< 3.0"
end
