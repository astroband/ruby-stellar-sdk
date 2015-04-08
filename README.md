# Stellar::Base

[![Build Status](https://travis-ci.org/stellar/ruby-stellar-base.svg)](https://travis-ci.org/stellar/ruby-stellar-base)
[![Code Climate](https://codeclimate.com/github/stellar/ruby-stellar-base/badges/gpa.svg)](https://codeclimate.com/github/stellar/ruby-stellar-base)

The stellar-base library is the lowest-level stellar helper library.  It consists of classes
to read, write, hash, and sign the xdr structures that are used in stellard.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stellar-base'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stellar-base

Also requires libsodium. Installable via `brew install libsodium` on OS X.

## Usage

[Examples are here](examples)

In addition to the code generated from the XDR definition files (see [ruby-xdr](https://github.com/stellar/ruby-xdr) for example usage), this library also provides some stellar specific features.  Let's look at some of them.

We wrap rbnacl with `Stellar::KeyPair`, providing some stellar specific functionality as seen below:

```ruby

# Create a keypair from a stellar secret seed
signer = Stellar::KeyPair.from_seed("s3tUdZbCmLoMdrZ6nhqztatMFaiD85P54oVj93g1NeSBwWQpTnE")

# Create a keypair from a stellar address
verifier = Stellar::KeyPair.from_address("gsTe6bDX54bPwtUAm2TER4shBF8nQNVtEvB8fmRkRoWvq3Y8XmY")

# Produce a stellar compliant "decorated signature" that is compliant with stellar transactions

signer.sign_decorated("Hello world!") # => #<Stellar::DecoratedSignature ...>

```

This library also provides an impementation of base58 and base58check encoding, with support for the bitcoin and stellar alphabets:

```ruby
b58 = Stellar::Util::Base58.stellar

encoded = b58.encode("\x00\x00\x00") # => "ggg"
b58.decode(encoded) # => "\x00\x00\x00"

# we can also use check encoding

b58.check_encode(:account_id, "\x00\x00\x00") # => "gggghbdQd2"
b58.check_encode(:seed, "\x00\x00\x00") # => "aX9UTew55Eh"

# To prevent interpretation mistakes, you must pass the expected version byte
# when decoding a check_encoded value

encoded = b58.check_encode(:account_id, "\x00\x00\x00")
b58.check_decode(:account_id, encoded) # => "\x00\x00\x00"
b58.check_decode(:seed, encoded) # => throws ArgumentError: Unexpected version: :account_id

```

## Caveats

The current integration of user-written code with auto-generated classes is to put it nicely, weird.  We intend to segregate the auto-generated code into its own namespace and refrain from monkey patching them.  This will happen before 1.0, and hopefully will happen soon.

## Contributing

Please [see CONTRIBUTING.md for details](CONTRIBUTING.md).

