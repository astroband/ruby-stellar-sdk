# Automatically generated on 2015-03-30T09:46:32-07:00
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
