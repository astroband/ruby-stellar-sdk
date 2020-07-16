#!/usr/bin/env ruby

require "stellar-base"

master = Stellar::KeyPair.master
destination = Stellar::KeyPair.master

tx1 = Stellar::TransactionBuilder.payment({
  source_account: master,
  destination: destination,
  sequence_number: 1,
  amount: [:native, 20]
})

tx2 = Stellar::TransactionBuilder.payment({
  source_account: master,
  destination: destination,
  sequence_number: 2,
  amount: [:native, 20]
})

hex = tx1.merge(tx2).to_envelope(master).to_xdr(:base64)
puts hex
