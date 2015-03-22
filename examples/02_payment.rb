require 'stellar'

account = Stellar::Account.from_seed("s3fu5vCMrfYouKuk2uB1gCD7EsuuBKY9M4qmnniQMBFMWR6Gaqm") 
client  = Stellar::Client.default_testnet()

# create a random recipients
recipient = Stellar::Account.random

# make a payment
client.send_payment({
  from:   account,
  to:     recipient,
  amount: Stellar::Amount.new(100_000000)
}) # => #<OK>

