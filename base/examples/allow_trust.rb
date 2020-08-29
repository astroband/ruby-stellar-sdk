#!/usr/bin/env ruby

require "rest-client"
require "stellar-base"

# This is an example of using a higher level allow_trust operation.
# This assumes that a stellar account is already created and a trustline
# to an anchor's asset has been established.

HUG_ASSET_CODE = "HUG"

def sequence_from_account(account)
  data = get_account_data(account)
  data["sequence"].to_i
end

def get_account_data(keypair, network_url)
  response = RestClient.get "#{network_url}/accounts/#{keypair.address}"
  JSON.parse(response.body)
end

def submit_transaction_operation(xdr_envelope, network_url)
  response = RestClient.post "#{network_url}/transactions", {tx: xdr_envelope}
  JSON.parse(response.body)
rescue RestClient::ExceptionWithResponse => e
  # handle exceptions here
end

def allow_trust(address, issuer_keypair)
  account = Stellar::KeyPair.from_address(address)
  current_sequence = sequence_from_account(issuer_keypair)

  tx = Stellar::TransactionBuilder.allow_trust({
    trustor: account,
    source_account: issuer_keypair,
    asset: [:alphanum4, HUG_ASSET_CODE, issuer_keypair],
    authorize: true,
    sequence_number: current_sequence + 1
  })

  xdr_envelope = tx.to_envelope(issuer_keypair).to_xdr(:base64)
  submit_transaction_operation(xdr_envelope)
end

# Usage:
# issuer_keypair must be a keypair from an anchor with both the public and
# private key i.e type Stellar::KeyPair
allow_trust("GCHOWITWOUNRUXGJWYUB4IMICZKROLHDRC2TJH5W324LBJVM4JUVXOZL", issuer_keypair)
