# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union switch (int v)
#       {
#       case 0:
#           void;
#       case 3:
#           AccountEntryExtensionV3 v3;
#       }
#
# ===========================================================================
module Stellar
  class AccountEntryExtensionV2
    class Ext < XDR::Union
      switch_on XDR::Int, :v

      switch 0
      switch 3, :v3

      attribute :v3, AccountEntryExtensionV3
    end
  end
end
