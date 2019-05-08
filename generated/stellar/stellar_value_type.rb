# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum StellarValueType
#   {
#       STELLAR_VALUE_BASIC = 0,
#       STELLAR_VALUE_SIGNED = 1
#   };
#
# ===========================================================================
module Stellar
  class StellarValueType < XDR::Enum
    member :stellar_value_basic,  0
    member :stellar_value_signed, 1

    seal
  end
end
