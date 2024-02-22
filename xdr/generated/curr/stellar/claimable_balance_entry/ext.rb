# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union switch (int v)
#       {
#       case 0:
#           void;
#       case 1:
#           ClaimableBalanceEntryExtensionV1 v1;
#       }
#
# ===========================================================================
module Stellar
  class ClaimableBalanceEntry
    class Ext < XDR::Union
      switch_on XDR::Int, :v

      switch 0
      switch 1, :v1

      attribute :v1, ClaimableBalanceEntryExtensionV1
    end
  end
end
