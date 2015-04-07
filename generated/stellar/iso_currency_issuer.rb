# Automatically generated on 2015-04-07T10:52:07-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct ISOCurrencyIssuer
#   {
#       opaque currencyCode[4];
#       AccountID issuer;
#   };
#
# ===========================================================================
module Stellar
  class ISOCurrencyIssuer < XDR::Struct
    attribute :currency_code, XDR::Opaque[4]
    attribute :issuer,        AccountID
  end
end
