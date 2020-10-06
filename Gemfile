source "https://rubygems.org"

gem "stellar-base", path: "./base"
gem "stellar-sdk", path: "./sdk"
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
  gem "standard", "0.5.2", require: false
  gem "vcr"
  gem "webmock"
end

group :development do
  gem "gem-release"
  gem "guard-rspec"
  gem "pry"
  gem "pry-doc"
  gem "netrc"
end
