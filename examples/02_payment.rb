require 'stellar-sdk'

client  = Stellar::Client.default_testnet()

puts "Creating random sender..."
from = Stellar::KeyPair.random
client.friendbot(from)
puts "Creating random recipient..."
recipient = Stellar::KeyPair.random
client.friendbot(recipient)

puts "Retrieving account's current sequence number..."
seq_num = client.account_info(from.address).sequence.to_i

puts "Constructing transaction..."
# construct TransactionBuilder and payment Operation
builder = Stellar::TransactionBuilder.new(
  source_account: from,
  sequence_number: seq_num + 1
)
# Note: if you want to send a non-native asset, :amount must take the form: 
# [<:alphanum12 or :alphanum4>, <code>, <issuer keypair>, <amount>]
payment_op = Stellar::Operation.payment({
  destination: recipient,
  amount: [:native, 100]
})

# add payment to transaction and set a 600ms timeout
tx = builder.add_operation(payment_op).set_timeout(600).build()
# sign transaction and get xdr
envelope = tx.to_envelope(from).to_xdr(:base64)

puts "Submitting transaction to horizon..."
# submit the transaction
begin
  client.horizon.transactions._post(tx: envelope)
rescue => e
  p e
else
  puts "Success!"
end
