# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union switch (int v)
#               {
#               case 0:
#                   void;
#               }
#
# ===========================================================================
module Stellar
  class TrustLineEntry
    class Ext
      class V1
        class Ext < XDR::Union
          switch_on XDR::Int, :v

          switch 0

        end
      end
    end
  end
end
