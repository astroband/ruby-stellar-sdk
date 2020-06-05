#!/usr/bin/env ruby

require 'stellar-base'

master      = Stellar::KeyPair.master
destination = Stellar::KeyPair.master

tx1 = Stellar::Transaction.payment({
  account:     master,
  destination: destination,
  sequence:    1,
  amount:      [:native, 20]
})

tx2 = Stellar::Transaction.payment({
  account:     master,
  destination: destination,
  sequence:    2,
  amount:      [:native, 20]
})

hex = tx1.merge(tx2).to_envelope(master).to_xdr(:base64)
puts hex
