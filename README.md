# Ruby Stellar

[![Build Status](https://travis-ci.org/stellar/ruby-stellar-sdk.svg)](https://travis-ci.org/stellar/ruby-stellar-sdk)
[![Code Climate](https://codeclimate.com/github/stellar/ruby-stellar-sdk/badges/gpa.svg)](https://codeclimate.com/github/stellar/ruby-stellar-sdk)

## This library has moved

The Stellar Ruby SDK is now maintained by the community: https://github.com/bloom-solutions/ruby-stellar-sdk

This library helps you to integrate your application into the [Stellar network](http://stellar.org).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stellar-sdk'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stellar-sdk

Also requires libsodium. Installable via `brew install libsodium` on OS X.

## Usage

See [examples](examples).

A simple payment from the root account to some random accounts

```ruby
require 'stellar-sdk'

account   = Stellar::Account.master
client    = Stellar::Client.default_testnet()
recipient = Stellar::Account.random

client.send_payment({
  from:   account,
  to:     recipient,
  amount: Stellar::Amount.new(100_000_000)
}) 
```

Be sure to set the network when submitting to the public network (more information in [stellar-base](https://www.github.com/stellar/ruby-stellar-base)):

```ruby
Stellar.default_network = Stellar::Networks::PUBLIC
```

## Development

- Copy `spec/config.yml.sample` to `spec/config.yml`
- Replace anything in `spec/config.yml` especially if you will re-record specs
- `rspec spec`

## Contributing

1. Sign the [Contributor License Agreement](https://docs.google.com/forms/d/1g7EF6PERciwn7zfmfke5Sir2n10yddGGSXyZsq98tVY/viewform?usp=send_form)
2. Fork it ( https://github.com/stellar/ruby-stellar-lib/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
