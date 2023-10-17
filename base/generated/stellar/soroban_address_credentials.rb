# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SorobanAddressCredentials
#   {
#       SCAddress address;
#       int64 nonce;
#       uint32 signatureExpirationLedger;
#       SCVal signature;
#   };
#
# ===========================================================================
module Stellar
  class SorobanAddressCredentials < XDR::Struct
    attribute :address,                     SCAddress
    attribute :nonce,                       Int64
    attribute :signature_expiration_ledger, Uint32
    attribute :signature,                   SCVal
  end
end
