#!/usr/bin/env ruby


require 'stellar-base'
require 'faraday'
require 'faraday_middleware'

$server = Faraday.new(url: "http://localhost:39132") do |conn|
  conn.response :json
  conn.adapter Faraday.default_adapter
end

master      = Stellar::KeyPair.from_raw_seed("allmylifemyhearthasbeensearching")
destination = Stellar::KeyPair.random

tx = Stellar::Transaction.create_account({
  account:     master,
  destination: destination,
  sequence:    1,
  starting_balance:  50_0000000
})

hex    = tx.to_envelope(master).to_xdr(:hex)

result = $server.get('tx', blob: hex)
p result.body
raw    = [result.body["result"]].pack("H*")
p Stellar::TransactionResult.from_xdr(raw)