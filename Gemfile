source "https://rubygems.org"

gem "stellar-base", path: "./base"
gem "stellar-sdk", path: "./sdk"
gem "stellar-horizon", path: "./horizon"
# gem "xdr", github: "astroband/ruby-xdr", branch: "main"

group :test do
  gem "codecov"
  gem "rake"
  gem "rspec"
  gem "rspec-its"
  gem "simplecov"
  if RUBY_VERSION >= "3.1"
    gem "vcr", github: "vcr/vcr" # use head version for Ruby 3.1 compat
  else
    gem "vcr"
  end
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
  gem "xdrgen"
end

group :guard, optional: true do
  gem "guard-rspec"
end
