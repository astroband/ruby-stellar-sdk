require "stellar-sdk"

account = Stellar::Account.from_seed("SBXH4SEH32PENMMB66P4TY6LXUIFMRVFUMX2LJC3P2STHICBJLNQJOH5")
client = Stellar::Client.default_testnet

# load the first page of transactions
transactions = client.transactions({
  account: account,
  order: :chronological
}) # => #<TransactionPage count=50 [...]>

# TransactionPage implements Enumerable...
transactions.first # => #<Stellar::Transaction ...>
transactions.each { |tx| p tx }
transactions.take(3) # => [...]

# ...but also has methods to advance pages
newer_transactions = transactions.next_page

# we can also just advance the current page in place
transactions.next_page!
