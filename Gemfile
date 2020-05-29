source "https://rubygems.org"

gem "stellar-base", path: "./base"
gem "stellar-sdk", path: "./sdk"

group :development do
  gem "faraday", "<= 0.16.2"
  gem "faraday_middleware"
  gem "guard-rspec", "~> 4.7"
  gem "netrc", "~> 0.11"
  gem "octokit", "~> 4.17"
  gem "pry"
  gem "rake", "~> 12.3", ">= 12.3.3"
  gem "rspec", "~> 3.1"
  gem "simplecov", "~> 0.18"
  gem "vcr", "~> 3.0"
  gem "webmock", "~> 2.3"
  gem "xdrgen", "~> 0.0"
  gem "yard", "~> 0.9"
  gem "xdr", git: "https://github.com/stellar/ruby-xdr.git", tag: "v3.0.1"
end

group :rubocop do
  gem "standard", "~> 0.3", require: false
  gem "rubocop-rspec", "~> 1.38", require: false
end
