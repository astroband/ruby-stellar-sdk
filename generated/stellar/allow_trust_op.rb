# This code was automatically generated using xdrgen
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
