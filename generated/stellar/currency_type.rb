# Automatically generated on 2015-04-26T19:13:29-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum CurrencyType
#   {
#       NATIVE = 0,
#       ISO4217 = 1
#   };
#
# ===========================================================================
module Stellar
  class CurrencyType < XDR::Enum
    member :native,  0
    member :iso4217, 1

    seal
  end
end
