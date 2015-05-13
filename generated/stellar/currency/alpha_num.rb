# Automatically generated on 2015-05-13T15:00:04-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           opaque currencyCode[4];
#           AccountID issuer;
#       }
#
# ===========================================================================
module Stellar
  class Currency
    class AlphaNum < XDR::Struct
      attribute :currency_code, XDR::Opaque[4]
      attribute :issuer,        AccountID
    end
  end
end
