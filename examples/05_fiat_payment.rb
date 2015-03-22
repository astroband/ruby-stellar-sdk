require 'stellar'

account = Stellar::Account.from_seed("s3fu5vCMrfYouKuk2uB1gCD7EsuuBKY9M4qmnniQMBFMWR6Gaqm") 
client  = Stellar::Client.default_testnet()

issuer = Stellar::Account.lookup("issuer@haste.co.nz"))
currency = Stellar::Currency.iso4217("USD", issuer)

client.send({
  from:   account,
  to:     recipient,
  amount: Stellar::Amount.new(100, currency, issuer)
}) # => #<OK>