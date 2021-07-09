source "https://rubygems.org"

gem "stellar-base", path: "./base"
gem "stellar-sdk", path: "./sdk"
# gem "xdr", github: "astroband/ruby-xdr"

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
  gem "bundler-audit"
  gem "standard", "1.1.5", require: false
  gem "yard-junk", require: false
end

group :development do
  gem "awesome_print"
  gem "break"
  gem "faraday"
  gem "faraday_middleware"
  gem "gem-release", require: false
  gem "octokit"
  gem "pry"
  gem "pry-doc"
  gem "netrc"
  gem "xdrgen"
end

group :guard, optional: true do
  gem "guard-rspec"
end
