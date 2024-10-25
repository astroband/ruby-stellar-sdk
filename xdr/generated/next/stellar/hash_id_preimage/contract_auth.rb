# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           Hash networkID;
#           uint64 nonce;
#           AuthorizedInvocation invocation;
#       }
#
# ===========================================================================
module Stellar
  class HashIDPreimage
    class ContractAuth < XDR::Struct
      attribute :network_id, Hash
      attribute :nonce,      Uint64
      attribute :invocation, AuthorizedInvocation
    end
  end
end
