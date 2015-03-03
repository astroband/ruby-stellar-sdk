# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  module Inflation
    class InflationResult < XDR::Union
      switch_on InflationResultCode, :code
                       
      switch :success, :payouts
                             switch :default
                          
      attribute :payouts, XDR::VarArray[InflationPayout]
    end
  end
end
