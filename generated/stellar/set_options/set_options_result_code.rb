# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  module SetOptions
    class SetOptionsResultCode < XDR::Enum
      member :success,           0
      member :rate_fixed,        1
      member :rate_too_high,     2
      member :below_min_balance, 3
      member :malformed,         4

      seal
    end
  end
end
