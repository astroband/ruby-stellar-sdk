# Automatically generated on 2015-03-30T09:46:31-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class LedgerKey
    class TrustLine < XDR::Struct
      attribute :account_id, Uint256
      attribute :currency,   Currency
    end
  end
end
