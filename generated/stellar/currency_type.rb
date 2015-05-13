# Automatically generated on 2015-05-13T15:00:04-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum CurrencyType
#   {
#       CURRENCY_TYPE_NATIVE = 0,
#       CURRENCY_TYPE_ALPHANUM = 1
#   };
#
# ===========================================================================
module Stellar
  class CurrencyType < XDR::Enum
    member :currency_type_native,   0
    member :currency_type_alphanum, 1

    seal
  end
end
