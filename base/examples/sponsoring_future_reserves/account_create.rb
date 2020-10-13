require "stellar-sdk"
require "stellar-base"

include Stellar::DSL

horizon_client = Stellar::Client.default_testnet

network_passphrase = Stellar::Networks::TESTNET

# GB5YQJSRJZZSLXRY7TXJT5GKYE7OJVJ6SBMU4EJFT6Y5KUE4PZ5RFNRK
sponsoring_keypair = KeyPair("SDZ7NRN32BWTWZWREGKFPCUR5JJCVOXNNV3IGU64TWHULSM7RC5DFT6R")
# GC4R4DDWBGM3J2XLUZXANVMLE57VREOBAWT33SF55KLDNB2HTLI4CAQJ
creating_keypair = KeyPair("SDDK4JCYFDTLDZB6VC6UPEJPLJOIAV6T2CCAIG746YWGDZ2YLPWOUFRK")
new_account_keypair = KeyPair() # random

seq_num = horizon_client.account_info(creating_keypair.address).sequence.to_i

tb = Stellar::TransactionBuilder.new(
  source_account: creating_keypair,
  sequence_number: seq_num + 1,
)

tb
  .add_operation(
    Stellar::Operation.begin_sponsoring_future_reserves(
      source_account: sponsoring_keypair,
      sponsored_keypair: new_account_keypair,
    )
  )
  .add_operation(
    Stellar::Operation.create_account(
      source_account: creating_keypair,
      destination: new_account_keypair,
      starting_balance: 450,
    )
  )
  .add_operation(
    Stellar::Operation.end_sponsoring_future_reserves(
      source_account: new_account_keypair,
    )
  )

tx = tb.build
envelope = tx.to_envelope(creating_keypair, sponsoring_keypair, new_account_keypair)

response = horizon_client.submit_transaction(tx_envelope: envelope)
p "Transaction was submitted successfully. It's hash is #{response.id}"
