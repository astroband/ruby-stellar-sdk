# Automatically generated on 2015-05-13T15:00:04-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   union switch (CurrencyType type)
#       {
#       // CURRENCY_TYPE_NATIVE is not allowed
#       case CURRENCY_TYPE_ALPHANUM:
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

      switch :currency_type_alphanum, :currency_code

      attribute :currency_code, XDR::Opaque[4]
    end
  end
end
