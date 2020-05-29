require_relative "./lib/stellar/version"

Gem::Specification.new do |spec|
  spec.name = "stellar-base"
  spec.version = Stellar::Base::VERSION
  spec.authors = ["Scott Fleckenstein"]
  spec.email = ["scott@stellar.org"]
  spec.summary = "Stellar client library: XDR"
  spec.homepage = "https://github.com/stellar/ruby-stellar-base"
  spec.license = "Apache-2.0"

  spec.files = Dir[
    "lib/**/*",
    "generated/**/*",
    "README.md",
    "CHANGELOG.md",
    "LICENSE",
  ]
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["generated", "lib"]

  spec.add_dependency "xdr", "~> 3.0.1"
  spec.add_dependency "digest-crc", ">= 0.5"
  spec.add_dependency "base32", ">= 0.3"
  spec.add_dependency "rbnacl", ">= 6.0"
  spec.add_dependency "activesupport", ">= 5.0.0"
end
