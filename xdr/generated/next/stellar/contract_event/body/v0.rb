# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#           {
#               SCVec topics;
#               SCVal data;
#           }
#
# ===========================================================================
module Stellar
  class ContractEvent
    class Body
      class V0 < XDR::Struct
        attribute :topics, SCVec
        attribute :data,   SCVal
      end
    end
  end
end
