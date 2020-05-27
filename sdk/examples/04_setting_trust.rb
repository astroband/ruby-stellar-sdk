require "stellar-sdk"

client = Stellar::Client.default_testnet

# A fake issuer for BTC
issuer = Stellar::KeyPair.from_seed("SALQBNNRCXWD32E4QKIXKXCMXCPJKWUP34EAK53SP6PNGAUVWSAM5IUQ")

puts "Creating random account..."
account_kp = Stellar::KeyPair.random
client.friendbot(account_kp)

puts "Retrieving account's current sequence number..."
seq_num = client.account_info(account_kp.address).sequence.to_i

puts "Constructing transaction..."
builder = Stellar::TransactionBuilder.new(
  source_account: account_kp,
  sequence_number: seq_num + 1
)
change_trust_op = Stellar::Operation.change_trust({
  line: Stellar::Asset.alphanum4("BTC", issuer),
  limit: 1000 # this is optional
})
tx = builder.add_operation(change_trust_op).set_timeout(600).build
envelope = tx.to_envelope(account_kp).to_xdr(:base64)

puts "Submitting transaction to horizon..."
client.horizon.transactions._post(tx: envelope)

puts "Success!"
