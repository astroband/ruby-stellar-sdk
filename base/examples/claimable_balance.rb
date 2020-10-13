require "stellar-base"

require "amazing_print"
require "json"
require "net/http"
require "uri"

base_endpoint = URI("https://horizon-testnet.stellar.org/")

fetch_sequence = ->(account) do
  response = Net::HTTP.get(base_endpoint + "accounts/#{account}")

  JSON.parse(response, symbolize_names: true)[:sequence]&.to_i.tap { |res| ap "Got #{res} for #{account}" }
end

submit_tx = ->(tx_envelope) do
  response = Net::HTTP.post_form(base_endpoint + 'transactions/', tx: tx_envelope.to_xdr(:base64))

  JSON.parse(response.body, symbolize_names: true)
end

include Stellar::DSL

network_passphrase = Stellar::Networks::TESTNET
sponsor_keypair = KeyPair("SAR2GU5YPVG2Y5I4OSQN2O3WTGSTTENSNUOVNO2LHPMC4B32W4Z2YNPB")
claimant_keypair = KeyPair("SDHNCLQ2JJDGBCZFLSIP5PGHFJXZMA6SH4Y5PRT4HJLR7ZYFAL74VSCU")

tx_create = Stellar::TransactionBuilder.create_claimable_balance(
    network_passphrase: network_passphrase,
    source_account: sponsor_keypair,
    sequence_number: fetch_sequence.(sponsor_keypair.address) + 1,
    asset: Stellar::Asset.native,
    amount: 100,
    claimants: [
      Claimant(sponsor_keypair), # unconditional
      Claimant(claimant_keypair) { before_relative_time(1.week) & ~before_relative_time(15.minutes) }
    ]
  )

tx_create_envelop = tx_create.to_envelope(sponsor_keypair)
tx_create_response = submit_tx.(tx_create_envelop)

ap tx_create_response
