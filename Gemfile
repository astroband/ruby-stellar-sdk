source "https://rubygems.org"

gem "stellar-base", path: "./base"
gem "stellar-sdk", path: "./sdk"
# gem "xdr", github: "astroband/ruby-xdr"
# gem "xdrgen", github: "astroband/xdrgen", group: :development

group :test do
  gem "rake"
  gem "rspec"
  gem "rspec-its"
  gem "vcr"
  gem "yard"
  gem "webmock"

  gem "codecov", require: false
  gem "simplecov", "~> 0.19.0", require: false
  gem "simplecov_json_formatter"
end

group :lint do
  gem "bundler-audit"
  gem "standard", "0.8.1", require: false
  gem "yard-junk", require: false
end

group :development do
  gem "amazing_print"
  gem "break"
  gem "faraday"
  gem "faraday_middleware"
  gem "gem-release", require: false
  gem "octokit"
  gem "pry"
  gem "pry-doc"
  gem "netrc"
end

group :guard, optional: true do
  gem "guard-rspec"
end
