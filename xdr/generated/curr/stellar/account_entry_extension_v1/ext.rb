# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union switch (int v)
#       {
#       case 0:
#           void;
#       case 2:
#           AccountEntryExtensionV2 v2;
#       }
#
# ===========================================================================
module Stellar
  class AccountEntryExtensionV1
    class Ext < XDR::Union
      switch_on XDR::Int, :v

      switch 0
      switch 2, :v2

      attribute :v2, AccountEntryExtensionV2
    end
  end
end
