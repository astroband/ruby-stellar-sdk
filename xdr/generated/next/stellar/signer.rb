# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct Signer
#   {
#       SignerKey key;
#       uint32 weight; // really only need 1 byte
#   };
#
# ===========================================================================
module Stellar
  class Signer < XDR::Struct
    attribute :key,    SignerKey
    attribute :weight, Uint32
  end
end
