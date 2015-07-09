# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct Signer
#   {
#       AccountID pubKey;
#       uint32 weight; // really only need 1byte
#   };
#
# ===========================================================================
module Stellar
  class Signer < XDR::Struct
    attribute :pub_key, AccountID
    attribute :weight,  Uint32
  end
end
