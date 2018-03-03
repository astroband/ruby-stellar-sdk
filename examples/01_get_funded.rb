require 'stellar'

# Reference an account from a secret seed
account = Stellar::Account.from_seed("s3fu5vCMrfYouKuk2uB1gCD7EsuuBKY9M4qmnniQMBFMWR6Gaqm") 
 
# Further options
# 
# Make a random account
# 
#   account = Stellar::Account.random()
#
# Reference an account (unauthenticated) from an address
# 
#   account = Stellar::Account.from_address("gjgPNE2GpySt5iYZaFFo1svCJ4gbHwXxUy8DDqeYTDK6UzsPTs")
#
# Reference an account (unauthenticated) from a federation name
# 
#   account = Stellar::Account.lookup("nullstyle*stellarfed.org")
#   account = Stellar::Account.lookup("nullstyle@gmail.com*stellarfed.org")
# 

# create a connection to the stellar network
client = Stellar::Client.default_testnet()

# Further options
# 
# Connect to the live network (when it is created)
# 
#   client = Stellar::Client.default
# 
# Connect to a specific horizon host
# 
#   client = Stellar::Client.new(host: "127.0.0.1")

# Get our friendly friendbot to
# fund your new account
response = client.friendbot(account)  # => #<OK>
