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
require 'faraday_middleware'

$server = Faraday.new(url: "http://localhost:39132") do |conn|
  conn.response :json
  conn.adapter Faraday.default_adapter
end

def submit(key, tx)
  hex      = tx.to_envelope(key).to_xdr(:hex)
  response = $server.get('tx', blob: hex)
  raw = [response.body["result"]].pack("H*")
  Stellar::TransactionResult.from_xdr(raw)
end

master      = Stellar::KeyPair.from_raw_seed("masterpassphrasemasterpassphrase")
destination = Stellar::KeyPair.random

submit master, Stellar::Transaction.payment({
  account:     master,
  destination: destination,
  sequence:    1,
  amount:      [:native, 2000_000000]
})

submit destination, Stellar::Transaction.change_trust({
  account:    destination,
  sequence:   1,
  line:       [:iso4217, "USD\x00", master],
  limit:      1000
})

submit master, Stellar::Transaction.payment({
  account:     master,
  destination: destination,
  sequence:    2,
  amount:      [:iso4217, "USD\x00", master, 100]
})
