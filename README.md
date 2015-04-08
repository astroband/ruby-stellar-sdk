# Ruby Stellar

[![Build Status](https://travis-ci.org/stellar/ruby-stellar-lib.svg)](https://travis-ci.org/stellar/ruby-stellar-lib)
[![Code Climate](https://codeclimate.com/github/stellar/ruby-stellar-lib/badges/gpa.svg)](https://codeclimate.com/github/stellar/ruby-stellar-lib)

*STATUS:  this library is very early and incomplete.  The examples provided do not work, yet*

This library helps you to integrate your application into the [Stellar network](http://stellar.org).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stellar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stellar

Also requires libsodium. Installable via `brew install libsodium` on OS X.

## Usage

See [examples](examples).

A simple payment from the root account to some random accounts

```ruby
require 'stellar'

account   = Stellar::Account.master
client    = Stellar::Client.default_testnet()
recipient = Stellar::Account.random

client.send_payment({
  from:   account,
  to:     recipient,
  amount: Stellar::Amount.new(100_000000)
}) 
```

## Contributing

1. Sign the [Contributor License Agreement](https://docs.google.com/forms/d/1g7EF6PERciwn7zfmfke5Sir2n10yddGGSXyZsq98tVY/viewform?usp=send_form)
2. Fork it ( https://github.com/stellar/ruby-stellar-lib/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
