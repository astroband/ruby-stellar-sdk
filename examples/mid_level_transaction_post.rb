#!/usr/bin/env ruby

# This is an example of using the higher level "payment" wrapper. Notice
# that we are using KeyPair instead of the raw rbnacl keys and that we need
# not build the entire heirarchy of xdr object manually.
#
# You can see where these helpers are defined in the files underneath /lib,
# which is where we extend the xdrgen generated source files with our higher
# level api.

require 'stellar-core'
require 'faraday'

master      = Stellar::KeyPair.from_raw_seed("masterpassphrasemasterpassphrase")
destination = Stellar::KeyPair.random

tx = Stellar::Transaction.payment({
  account:     master,
  destination: destination,
  sequence:    4,
  amount:      [:native, 20000000]
})

hex    = tx.to_envelope(master).to_xdr(:hex)
result = Faraday.get('http://localhost:39132/tx', blob: hex)
puts result.body