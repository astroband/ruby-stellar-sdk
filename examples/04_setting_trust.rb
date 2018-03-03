require 'stellar'

account = Stellar::Account.from_seed("s3fu5vCMrfYouKuk2uB1gCD7EsuuBKY9M4qmnniQMBFMWR6Gaqm") 
client  = Stellar::Client.default_testnet()

issuer = Stellar::Account.lookup("tips*stellarid.io")
asset = Stellar::Asset.credit_alphanum4("USD", issuer)

client.trust({
  account:  account
  asset: asset
})
