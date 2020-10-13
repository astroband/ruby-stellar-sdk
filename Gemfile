source "https://rubygems.org"

gem "stellar-base", path: "./base"
gem "stellar-sdk", path: "./sdk"
gem "xdr", github: "astroband/ruby-xdr"
gem "xdrgen", github: "astroband/xdrgen", group: :development

gem "rake"
gem "yard"

platforms :jruby do
  gem "jruby-openssl", "0.10.4"
end

group :development, :test do
  gem "bundler-audit"
  gem "faraday"
  gem "faraday_middleware"
  gem "octokit"
  gem "rspec"
  gem "rspec-its"
  gem "simplecov", require: false
  gem "simplecov_json_formatter"
  gem "standard", require: false
  gem "vcr"
  gem "webmock"
end

group :development do
  gem "amazing_print"
  gem "break"
  gem "gem-release"
  gem "guard-rspec"
  gem "pry"
  gem "pry-doc"
  gem "pry-docmore"
  gem "netrc"
end
