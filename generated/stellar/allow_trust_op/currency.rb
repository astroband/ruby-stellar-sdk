# Automatically generated on 2015-05-07T07:56:23-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   union switch (CurrencyType type)
#       {
#       // NATIVE is not allowed
#       case ISO4217:
#           opaque currencyCode[4];
#   
#           // add other currency types here in the future
#       }
#
# ===========================================================================
module Stellar
  class AllowTrustOp
    class Currency < XDR::Union
      switch_on CurrencyType, :type

      switch :iso4217, :currency_code

      attribute :currency_code, XDR::Opaque[4]
    end
  end
end
