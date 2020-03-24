require 'stellar-sdk'

client  = Stellar::Client.default_testnet()

puts "Creating random recipient..."
recipient = Stellar::KeyPair.random
client.friendbot(recipient)

from = Stellar::KeyPair.from_seed("SBXH4SEH32PENMMB66P4TY6LXUIFMRVFUMX2LJC3P2STHICBJLNQJOH5") 

puts "Retrieving issuer for USD..."
issuer_address = Stellar::Account.lookup("tips*stellarid.io")
issuer = Stellar::KeyPair.from_address(issuer_address)

puts "Retrieving account's current sequence number..."
seq_num = client.account_info(from.address).sequence.to_i

puts "Constructing transaction..."
# construct TransactionBuilder and payment Operation
builder = Stellar::TransactionBuilder.new(
  source_account: from,
  sequence_number: seq_num + 1
)
# construct payment op
payment_op = Operation.payment({
  destination: recipient,
  amount: [:alphanum4, "USD", issuer, 10] 
})
# add payment to transaction and set a 600ms timeout
tx = builder.add_operation(payment_op).set_timeout(600).build()
# sign transaction and get xdr
envelope = tx.to_envelope(from).to_xdr(:base64)

puts "Submitting transaction to horizon..."
# submit the transaction
client.horizon.transactions._post(tx: envelope)