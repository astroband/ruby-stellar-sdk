#!/usr/bin/env ruby

require "stellar-base"
require "faraday"
require "faraday_middleware"

$server = Faraday.new(url: "http://localhost:39132") { |conn|
  conn.response :json
  conn.adapter Faraday.default_adapter
}

master = Stellar::KeyPair.master
destination = Stellar::KeyPair.random

tx = Stellar::Transaction.create_account({
  account: master,
  destination: destination,
  sequence: 1,
  starting_balance: 50
})

b64 = tx.to_envelope(master).to_xdr(:base64)
p b64
result = $server.get("tx", blob: b64)
p result.body
