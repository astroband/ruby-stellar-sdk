#!/usr/bin/env ruby

require 'stellar-base'

master      = Stellar::KeyPair.from_raw_seed("allmylifemyhearthasbeensearching")
destination = Stellar::KeyPair.from_raw_seed("allmylifemyhearthasbeensearching")

tx1 = Stellar::Transaction.payment({
  account:     master,
  destination: destination,
  sequence:    1,
  amount:      [:native, 20 * Stellar::ONE]
})

tx2 = Stellar::Transaction.payment({
  account:     master,
  destination: destination,
  sequence:    2,
  amount:      [:native, 20 * Stellar::ONE]
})

hex = tx1.merge(tx2).to_envelope(master).to_xdr(:base64)
puts hex
