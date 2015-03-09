# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class ChangeTrustOp < XDR::Struct
    attribute :line,  Currency
    attribute :limit, Int64
  end
end
