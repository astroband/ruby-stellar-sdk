require 'xdr'
require 'rbnacl'
require 'digest/sha2'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/enumerable'
require 'active_support/core_ext/kernel/reporting'

# See ../generated for code-gen'ed files

silence_warnings do
  require 'SCPXDR'
  require 'Stellar-types'
  require 'Stellar-overlay'
  require 'Stellar-ledger'
  require 'Stellar-transaction'
  require 'Stellar-ledger-entries'
end
Stellar.load_all!

# extensions onto the generated files must be loaded manually, below

require_relative './stellar/change_trust_op'
require_relative './stellar/currency'
require_relative './stellar/key_pair'
require_relative './stellar/payment_op'
require_relative './stellar/transaction'
require_relative './stellar/transaction_envelope'
require_relative './stellar/util/base58'