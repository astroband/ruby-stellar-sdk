source "https://rubygems.org"

gem "stellar-base", path: "./base"
gem "stellar-sdk", path: "./sdk"
gem "stellar-horizon", path: "./horizon"
# gem "xdr", github: "astroband/ruby-xdr", branch: "main"
# gem "xdrgen" # , path: "../xdrgen"

group :test do
  gem "rake"
  gem "rspec"
  gem "rspec-its"
  gem "simplecov", require: false
  gem "simplecov-lcov", require: false
  gem "simplecov-tailwindcss", require: false
  gem "simplecov_json_formatter", require: false
  gem "simplecov-cobertura", require: false
  gem "vcr"
  gem "yard"
  gem "webmock"
end

group :lint do
  gem "bundler-audit", require: false
  gem "standard", require: false
  gem "yard-junk", require: false
end

group :development do
  gem "awesome_print"
  gem "break"
  gem "gem-release", require: false
  gem "octokit"
  gem "netrc"
  gem "pry"
  gem "pry-doc"
end

group :guard, optional: true do
  gem "guard-rspec"
end

platform :mri do
  # To silence warnings about default gems
  gem "fiddle"
  gem "rdoc"
end
