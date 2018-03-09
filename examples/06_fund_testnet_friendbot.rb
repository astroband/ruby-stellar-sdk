require 'stellar-sdk'

client  = Stellar::Client.default_testnet

friendbot = Stellar::Account.from_seed("SBXH4SEH32PENMMB66P4TY6LXUIFMRVFUMX2LJC3P2STHICBJLNQJOH5")

# Give 10 million lumens
client.create_account({
  funder:           Stellar::Account.master,
  account:          friendbot,
  starting_balance: 10_000_000 * Stellar::ONE,
  sequence: 1,
})

puts friendbot.address
