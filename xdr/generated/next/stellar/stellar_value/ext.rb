# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union switch (StellarValueType v)
#       {
#       case STELLAR_VALUE_BASIC:
#           void;
#       case STELLAR_VALUE_SIGNED:
#           LedgerCloseValueSignature lcValueSignature;
#       }
#
# ===========================================================================
module Stellar
  class StellarValue
    class Ext < XDR::Union
      switch_on StellarValueType, :v

      switch :stellar_value_basic
      switch :stellar_value_signed, :lc_value_signature

      attribute :lc_value_signature, LedgerCloseValueSignature
    end
  end
end
