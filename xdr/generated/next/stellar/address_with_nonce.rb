# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct AddressWithNonce
#   {
#       SCAddress address;
#       uint64 nonce;
#   };
#
# ===========================================================================
module Stellar
  class AddressWithNonce < XDR::Struct
    attribute :address, SCAddress
    attribute :nonce,   Uint64
  end
end
