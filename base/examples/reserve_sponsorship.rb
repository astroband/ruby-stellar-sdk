require "stellar-sdk"
require "stellar-base"

include Stellar::DSL

horizon_client = Stellar::Client.default_testnet

network_passphrase = Stellar::Networks::TESTNET

# GB5YQJSRJZZSLXRY7TXJT5GKYE7OJVJ6SBMU4EJFT6Y5KUE4PZ5RFNRK
sponsoring = KeyPair("SDZ7NRN32BWTWZWREGKFPCUR5JJCVOXNNV3IGU64TWHULSM7RC5DFT6R")
# GC4R4DDWBGM3J2XLUZXANVMLE57VREOBAWT33SF55KLDNB2HTLI4CAQJ
sponsored = KeyPair("SDDK4JCYFDTLDZB6VC6UPEJPLJOIAV6T2CCAIG746YWGDZ2YLPWOUFRK")
new_account = KeyPair() # random
asset = Stellar.Asset("RUBY-#{sponsoring.address}")
lumens = Stellar.Asset("XLM-native")

seq_num = horizon_client.account_info(sponsoring.address).sequence.to_i

tb = Stellar::TransactionBuilder.new(
  source_account: sponsoring,
  network_passphrase: network_passphrase,
  sequence_number: seq_num + 1,
).add_operation(
    Stellar::Operation.begin_sponsoring_future_reserves(
      sponsored: new_account
    )
).add_operation(
    Stellar::Operation.create_account(
      destination: new_account,
      starting_balance: 0
    )
).add_operation(
    Stellar::Operation.change_trust(
      source_account: new_account,
      line: asset,
      limit: 10000
    )
).add_operation(
  Stellar::Operation.payment(
    source_account: sponsoring,
    destination: new_account,
    amount: [asset, 1000]
  )
).add_operation(
  Stellar::Operation.manage_sell_offer(
    source_account: new_account,
    selling: asset,
    buying: lumens,
    amount: 100,
    price: 0.1
  )
).add_operation(
    Stellar::Operation.end_sponsoring_future_reserves(
      source_account: new_account
    )
)

tx = tb.build
envelope = tx.to_envelope(sponsoring, new_account)

response = horizon_client.submit_transaction(tx_envelope: envelope)
p "Transaction was submitted successfully. It's hash is #{response.id}"
pp response
