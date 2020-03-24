require 'xdr'
require 'rbnacl'
require 'digest/sha2'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/enumerable'
require 'active_support/core_ext/kernel/reporting'

# See ../generated for code-gen'ed files
silence_warnings do
  require 'stellar-base-generated'
end
Stellar.load_all!

Stellar::ONE = 1_0000000


# extensions onto the generated files must be loaded manually, below

require_relative './stellar/account_flags'
require_relative './stellar/asset'
require_relative './stellar/key_pair'
require_relative './stellar/operation'
require_relative './stellar/path_payment_strict_receive_result'
require_relative './stellar/price'
require_relative './stellar/signer_key'
require_relative './stellar/thresholds'
require_relative './stellar/transaction'
require_relative './stellar/transaction_builder'
require_relative './stellar/transaction_envelope'
require_relative './stellar/util/strkey'
require_relative './stellar/util/continued_fraction'
require_relative './stellar/convert'
require_relative './stellar/networks'
require_relative './stellar/base/version'

require_relative './stellar/base/compat'
