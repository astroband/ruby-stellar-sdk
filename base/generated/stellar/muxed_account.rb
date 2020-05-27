# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union MuxedAccount switch (CryptoKeyType type)
#   {
#   case KEY_TYPE_ED25519:
#       uint256 ed25519;
#   case KEY_TYPE_MUXED_ED25519:
#       struct
#       {
#           uint64 id;
#           uint256 ed25519;
#       } med25519;
#   };
#
# ===========================================================================
module Stellar
  class MuxedAccount < XDR::Union
    include XDR::Namespace

    autoload :Med25519

    switch_on CryptoKeyType, :type

    switch :key_type_ed25519,       :ed25519
    switch :key_type_muxed_ed25519, :med25519

    attribute :ed25519,  Uint256
    attribute :med25519, Med25519
  end
end
