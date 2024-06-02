# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           Hash networkID;
#           int64 nonce;
#           uint32 signatureExpirationLedger;
#           SorobanAuthorizedInvocation invocation;
#       }
#
# ===========================================================================
module Stellar
  class HashIDPreimage
    class SorobanAuthorization < XDR::Struct
      attribute :network_id,                  Hash
      attribute :nonce,                       Int64
      attribute :signature_expiration_ledger, Uint32
      attribute :invocation,                  SorobanAuthorizedInvocation
    end
  end
end
