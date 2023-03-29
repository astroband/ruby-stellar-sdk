source "https://rubygems.org"

gem "stellar-base", path: "./base"
gem "stellar-sdk", path: "./sdk"
gem "stellar-horizon", path: "./horizon"
# gem "xdr", github: "astroband/ruby-xdr", branch: "main"
# gem "xdrgen" # , path: "../xdrgen"

group :test do
  gem "codecov"
  gem "rake"
  gem "rspec"
  gem "rspec-its"
  gem "simplecov"
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
  gem "pry"
  gem "pry-doc"
  gem "netrc"
end

group :guard, optional: true do
  gem "guard-rspec"
end
