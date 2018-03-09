require 'stellar-sdk'

account = Stellar::Account.from_seed("SBXH4SEH32PENMMB66P4TY6LXUIFMRVFUMX2LJC3P2STHICBJLNQJOH5") 
client  = Stellar::Client.default_testnet()

# create a random recipients
recipient = Stellar::Account.random

# make a payment
client.send_payment({
  from:   account,
  to:     recipient,
  amount: Stellar::Amount.new(100_000_000)
}) # => #<OK>

