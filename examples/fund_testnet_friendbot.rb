require 'stellar'

client  = Stellar::Client.default_testnet()

# Give 10 million lumens
client.send_payment({
  from:   Stellar::Account.master,
  to:     Stellar::Account.from_seed("s3fu5vCMrfYouKuk2uB1gCD7EsuuBKY9M4qmnniQMBFMWR6Gaqm") ,
  amount: Stellar::Amount.new(10_000000_0000000)
})