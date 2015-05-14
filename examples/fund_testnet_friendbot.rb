require 'stellar'

client  = Stellar::Client.default_testnet()

friendbot = Stellar::Account.from_seed("s3fu5vCMrfYouKuk2uB1gCD7EsuuBKY9M4qmnniQMBFMWR6Gaqm")

# Give 10 million lumens
client.create_account({
  funder:           Stellar::Account.master,
  account:          friendbot,
  starting_balance: 10_000000_0000000
})

puts friendbot.address