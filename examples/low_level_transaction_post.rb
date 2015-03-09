#!/usr/bin/env ruby

# This is an example of using the raw xdr objects to post a transaction
# notice that we must manually hash/sign the structures and we must manually
# fill out all the fields. 
#
# Look at mid_level_transaction_post.rb to see a friendlier form

require 'rbnacl'
require 'stellar-core'
require 'faraday'
require 'digest/sha2'

master      = RbNaCl::SigningKey.new("masterpassphrasemasterpassphrase")
destination = RbNaCl::SigningKey.new("masterpassphrasemasterpassphras3")

tx            = Stellar::Transaction.new
tx.account    = master.verify_key.to_bytes
tx.max_fee    = 1000
tx.seq_slot   = 0
tx.seq_num    = 1
tx.max_ledger = 1000
tx.min_ledger = 0

payment = Stellar::PaymentOp.new
payment.destination = destination.verify_key.to_bytes
payment.currency = Stellar::Currency.new(:native)
payment.path = []
payment.amount = 200_000000
payment.send_max = 200_000000
payment.source_memo = ""
payment.memo = ""

op = Stellar::Operation.new
op.body = Stellar::Operation::Body.new(:payment, payment)

tx.operations = [op]

raw       = tx.to_xdr
tx_hash   = Digest::SHA256.digest raw
signature = master.sign(tx_hash)

env = Stellar::TransactionEnvelope.new
env.tx = tx
env.signatures = [signature]

env_hex = env.to_xdr.unpack("H*").first

result = Faraday.get('http://localhost:39132/tx', blob: env_hex)
puts result.body

