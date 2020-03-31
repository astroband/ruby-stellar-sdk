# Ruby Stellar

[![Build Status](https://travis-ci.org/stellar/ruby-stellar-sdk.svg)](https://travis-ci.org/stellar/ruby-stellar-sdk)

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

A simple payment from the root account to some random account

```ruby
require 'stellar-sdk'

account   = Stellar::Account.master
client    = Stellar::Client.default_testnet()
recipient = Stellar::Account.random

next_seq_num = client.account_info(account).sequence.to_i + 1
tx = Stellar::TransactionBuilder.new(
  source_account: account.keypair,
  sequence_number: next_seq_num
).add_operation(
  Stellar::Operation.payment({
    destination: recipient,
    amount: [Stellar::Asset.native, 100]
  })
).add_timeout(600).build()
envelope = tx.to_envelope(account.keypair)
client.submit_transaction(tx_envelope: envelope) 
```

Be sure to set the network when submitting to the public network (more information in [stellar-base](https://www.github.com/stellar/ruby-stellar-base)):

```ruby
Stellar.default_network = Stellar::Networks::PUBLIC
```

## Development

- Install and activate [rvm](https://rvm.io/rvm/install)
- Ensure your `bundler` version is up-to-date: `gem install bundler`
- Run `bundle install`
- Copy `spec/config.yml.sample` to `spec/config.yml`
- Replace anything in `spec/config.yml` especially if you will re-record specs
- `bundle exec rspec spec`

## Contributing

1. Sign the [Contributor License Agreement](https://docs.google.com/forms/d/1g7EF6PERciwn7zfmfke5Sir2n10yddGGSXyZsq98tVY/viewform?usp=send_form)
2. Fork it ( https://github.com/stellar/ruby-stellar-sdk/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
