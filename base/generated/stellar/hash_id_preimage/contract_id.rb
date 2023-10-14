# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           Hash networkID;
#           ContractIDPreimage contractIDPreimage;
#       }
#
# ===========================================================================
module Stellar
  class HashIDPreimage
    class ContractID < XDR::Struct
      attribute :network_id,           Hash
      attribute :contract_id_preimage, ContractIDPreimage
    end
  end
end
