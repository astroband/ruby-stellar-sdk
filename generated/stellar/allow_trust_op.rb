# Automatically generated on 2015-05-13T15:00:04-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct AllowTrustOp
#   {
#       AccountID trustor;
#       union switch (CurrencyType type)
#       {
#       // CURRENCY_TYPE_NATIVE is not allowed
#       case CURRENCY_TYPE_ALPHANUM:
#           opaque currencyCode[4];
#   
#           // add other currency types here in the future
#       }
#       currency;
#   
#       bool authorize;
#   };
#
# ===========================================================================
module Stellar
  class AllowTrustOp < XDR::Struct
    include XDR::Namespace

    autoload :Currency

    attribute :trustor,   AccountID
    attribute :currency,  Currency
    attribute :authorize, XDR::Bool
  end
end
