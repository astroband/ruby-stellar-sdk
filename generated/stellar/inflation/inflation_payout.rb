# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  module Inflation
    class InflationPayout < XDR::Struct
      attribute :destination, AccountID
      attribute :amount,      Int64
    end
  end
end
