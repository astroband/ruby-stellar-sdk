# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  module Inflation
    class InflationResultCode < XDR::Enum
      member :success,  0
      member :not_time, 1

      seal
    end
  end
end
